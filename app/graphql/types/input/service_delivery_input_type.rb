# frozen_string_literal: true

module Types
  module Input
    class ServiceDeliveryInputType < Types::BaseInputObject
      argument :address_id, ID, required: false
      argument :total_cost, Float, required: false
    end
  end
end
