# frozen_string_literal: true

module Types
  module Input
    class ServiceInputType < Types::BaseInputObject
      argument :name, String, required: false
      argument :price_per_inch_of_snow, Integer, required: false
      argument :price_per_driveway, [Float], required: false
    end
  end
end
