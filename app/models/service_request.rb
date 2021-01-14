# frozen_string_literal: true

class ServiceRequest < ApplicationRecord
  validates :address, presence: true
  before_save :calculate_service_cost_subtotal

  belongs_to :address, inverse_of: :service_request
  has_one :early_bird, through: :address

  has_one :user, through: :address
  has_one :service_delivery, through: :address

  scope :with_early_birds, -> { includes(:early_bird).where.not(early_birds: { id: nil }) }
  scope :without_early_birds, -> { includes(:early_bird).where(early_birds: { id: nil }) }

  enum status: {
    pending: 0,
    confirmed: 1
  }

  def calculate_service_cost_subtotal
    services = Service.find(service_ids)
    price_index = Address.driveways[address.driveway]
    prices = services.each_with_object([]) do |service, memo|
      memo << service.price_per_driveway[price_index]
    end
    assign_attributes(service_subtotal: prices.sum)
  end
end
