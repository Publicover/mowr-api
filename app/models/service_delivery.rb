# frozen_string_literal: true

class ServiceDelivery < ApplicationRecord
  after_save :confirm_siblings

  belongs_to :address, inverse_of: :service_delivery

  has_one :size_estimate, through: :address
  has_one :service_request, through: :address

  # confirm size estimate of parent address

  STATE_TAX = 1.08

  def calculate_total_cost
    subtotal = service_request.calculate_service_cost_subtotal
    subtotal *= ServiceDelivery::STATE_TAX
    subtotal
    # subtotal += INCHES OF SNOW
  end

  def confirm_siblings
    size_estimate.confirmed!
    service_request.confirmed!
  end
end
