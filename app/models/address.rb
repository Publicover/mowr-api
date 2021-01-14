# frozen_string_literal: true

class Address < ApplicationRecord
  geocoded_by :compact_address
  after_validation :geocode, if: ->(obj) { obj.line1.present? && obj.city.present? && obj.latitude.blank? }

  belongs_to :user, inverse_of: :addresses

  has_one :size_estimate, inverse_of: :address, dependent: :destroy
  has_one :service_request, inverse_of: :address, dependent: :destroy
  has_one :early_bird, inverse_of: :address, dependent: :destroy
  has_one :service_delivery, inverse_of: :address, dependent: :destroy

  validates :line1, :city, :state, :zip, presence: true

  enum driveway: {
    small: 0,
    medium: 1,
    large: 2
  }

  scope :with_service_requests, lambda {
                                  includes(:service_request)
                                    .where(service_requests: { status: :confirmed })
                                    .where.not(service_requests: { id: nil })
                                }

  scope :with_current_service_requests, lambda {
                                          includes(:service_request)
                                            .where(service_requests: { status: :confirmed })
                                            .where('service_requests.created_at > ?', Time.zone.now.yesterday.end_of_day)
                                        }

  scope :with_early_birds, lambda {
                             includes(:early_bird)
                               .includes(:service_request)
                               .where(service_requests: { status: :confirmed })
                               .where.not(early_birds: { id: nil })
                               .where.not(service_requests: { id: nil })
                           }

  scope :without_early_birds, lambda {
                                includes(:early_bird)
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
    (service_delivery.last.created_at.day == DailyRoute.last.created_at.day) &&
    (service_delivery.last.created_at.month == DailyRoute.last.created_at.month) &&
    (service_delivery.last.created_at.year == DailyRoute.last.created_at.year)
  end

  def current_delivery
    service_delivery.last
  end

  def current_charges
    service_delivery.last.total_cost
  end

  def mark_serviced
    service_delivery.last.complete!
  end
end
