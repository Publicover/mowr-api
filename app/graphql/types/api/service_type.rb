# frozen_string_literal: true

module Types
  module Api
    class ServiceType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :price_per_inch_of_snow, Float, null: false
      field :price_per_driveway, [Float], null: false
    end
  end
end
