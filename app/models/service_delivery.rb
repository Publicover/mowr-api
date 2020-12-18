class ServiceDelivery < ApplicationRecord
  belongs_to :address, inverse_of: :service_delivery

  STATE_TAX = 1.08
end
