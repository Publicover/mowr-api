# frozen_string_literal: true

class Address < ApplicationRecord
  geocoded_by :compact_address
  after_validation :geocode, if: ->(obj) { obj.line1.present? && obj.city.present? && obj.latitude.blank? }
  before_save :check_service_area, if: ->(obj) { obj.service_address.blank? }

  belongs_to :user, inverse_of: :addresses

  has_one :size_estimate, inverse_of: :address, dependent: :destroy
  has_one :service_request, inverse_of: :address, dependent: :destroy
  has_one :early_bird, inverse_of: :address, dependent: :destroy
  has_many :service_deliveries, inverse_of: :address, dependent: :destroy

  validates :line1, :city, :state, :zip, presence: true

  enum driveway: {
    small: 0,
    medium: 1,
    large: 2
  }

  enum service_address: {
    active: 0,
    out_of_bounds: 1
  }

  scope :with_service_requests, lambda {
                                  includes(:service_request)
                                    .active
                                    .where(service_requests: { status: :confirmed })
                                    .where.not(service_requests: { id: nil })
                                }

  scope :with_current_service_requests, lambda {
                                          includes(:service_request)
                                            .active
                                            .where(service_requests: { status: :confirmed })
                                            .where(
                                              'service_requests.created_at > ?',
                                              Time.zone.now.yesterday.end_of_day
                                            )
                                        }

  scope :with_early_birds, lambda {
                             includes(:early_bird)
                               .includes(:service_request)
                               .active
                               .where(service_requests: { status: :confirmed })
                               .where.not(early_birds: { id: nil })
                               .where.not(service_requests: { id: nil })
                           }

  scope :without_early_birds, lambda {
                                includes(:early_bird)
                                  .active
                                  .includes(:service_request)
                                  .where(service_requests: { status: :confirmed })
                                  .where(early_birds: { id: nil })
                                  .where.not(service_requests: { id: nil })
                              }

  def compact_address
    components = [line1, city, state, zip]
    line2.blank? ? components.compact.join(',') : components.insert(1, line2).compact.join(',')
  end

  def service_ids
    service_request.blank? ? nil : service_request.service_ids
  end

  def serve_today?
    current_delivery.create_at.all_day == DailyRoute.last.created_at.all_day
  end

  def current_delivery
    service_deliveries.last
  end

  def current_charges
    current_delivery.total_cost
  end

  def mark_serviced
    current_delivery.complete!
  end

  def check_service_area
    BaseLocation.all.find_each do |location|
      active! if location.zip == zip
    end
  end
end
