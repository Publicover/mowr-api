# frozen_string_literal: true

class ServiceDeliverySerializer
  include FastJsonapi::ObjectSerializer
  attributes :total_cost, :address_id, :status

  belongs_to :address
end
