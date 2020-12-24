# frozen_string_literal: true

class ServiceDelivery < ApplicationRecord
  after_validation :confirm_siblings
  before_save :calculate_total_cost

  belongs_to :address, inverse_of: :service_delivery

  has_one :size_estimate, through: :address
  has_one :service_request, through: :address
  has_one :early_bird, through: :address

  # confirm size estimate of parent address

  STATE_TAX = 1.08

  def calculate_total_cost
    subtotal = service_request.service_subtotal
    services = Service.find(service_request.service_ids)
    prices = services.each_with_object([]) do |service, memo|
      memo << (service.price_per_inch_of_snow * SnowAccumulation.last.inches)
    end
    subtotal += prices.sum
    subtotal *= ServiceDelivery::STATE_TAX
    self.assign_attributes(total_cost: subtotal)
  end

  def confirm_siblings
    size_estimate.confirmed!
    service_request.confirmed!
  end
end
