# frozen_string_literal: true

class ServiceDelivery < ApplicationRecord
  after_validation :confirm_siblings
  before_save :calculate_total_cost

  belongs_to :address, inverse_of: :service_deliveries

  has_one :size_estimate, through: :address
  has_one :service_request, through: :address
  has_one :early_bird, through: :address
  has_one :user, through: :address

  enum status: {
    scheduled: 0,
    complete: 1,
    incomplete: 2,
    paid: 3
  }

  scope :deliveries_today, -> {
        scheduled.where('created_at > ?', Time.zone.yesterday.end_of_day + 1.hour)
  }

  STATE_TAX = 1.08

  def calculate_total_cost
    return unless service_request.confirmed?

    subtotal = service_request.service_subtotal
    services = Service.find(service_request.service_ids)
    prices = services.each_with_object([]) do |service, memo|
      memo << (service.price_per_inch_of_snow * SnowAccumulation.last.inches)
    end
    subtotal += prices.sum
    subtotal *= ServiceDelivery::STATE_TAX
    assign_attributes(total_cost: subtotal)
  end

  def confirm_siblings
    size_estimate.confirmed! if size_estimate.pending?
    service_request.confirmed! if service_request.pending?
  end

  def total_cost_in_cents
    (total_cost * 100).to_i
  end
end
