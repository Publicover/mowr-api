# frozen_string_literal: true

class ServiceRequest < ApplicationRecord
  validates :address, presence: true

  belongs_to :address, inverse_of: :service_request

  has_one :user, through: :address

  enum status: {
    pending: 0,
    confirmed: 1
  }

  def calculate_service_cost_subtotal
    services = Service.find(service_ids)
    price_index = Address.driveways[address.driveway]
    prices = services.each_with_object([]) do |service, memo|
      memo << service.price_per_driveway[price_index]
      # memo << (service.address * SnowAccumulation.last.inches)
    end
    prices.sum
  end
end
