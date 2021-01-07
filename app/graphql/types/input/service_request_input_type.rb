# frozen_string_literal: true

module Types
  module Input
    class ServiceRequestInputType < Types::BaseInputObject
      argument :status, Integer, required: false
      argument :service_subtotal, Float, required: false
      argument :service_ids, [Integer], required: false
      argument :address_id, ID, required: false
    end
  end
end
