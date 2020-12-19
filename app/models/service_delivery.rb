class ServiceDelivery < ApplicationRecord
  after_save :confirm_siblings

  belongs_to :address, inverse_of: :service_delivery

  # confirm size estimate of parent address

  STATE_TAX = 1.08

  def calculate_total_cost
    subtotal = service_request.calculate_service_cost_subtotal
    subtotal *= ServiceDelivery::STATE_TAX
    # subtotal += INCHES OF SNOW
  end

  def confirm_siblings
    address.size_estimate.update(status: :confirmed)
    address.service_request.update(status: :confirmed)
  end
end
