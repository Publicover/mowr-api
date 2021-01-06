# frozen_string_literal: true

module Types
  module Input
    class SizeEstimateInputType < Types::BaseInputObject
      argument :square_footage, Float, required: false
      argument :status, Integer, required: false
      argument :address_id, ID, required: false
    end
  end
end
