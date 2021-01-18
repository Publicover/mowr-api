# frozen_string_literal: true

module Types
  module Input
    class DailyRouteInputType < Types::BaseInputObject
      argument :addresses_in_order, [Integer], required: false
      argument :calculate_route, String, required: false
    end
  end
end
