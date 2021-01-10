# frozen_string_literal: true

module Types
  module Input
    class BaseLocationInputType < Types::BaseInputObject
      argument :line1, String, required: false
      argument :line2, String, required: false
      argument :city, String, required: false
      argument :state, String, required: false
      argument :zip, String, required: false
      argument :name, String, required: false
      argument :latitude, Float, required: false
      argument :longitude, Float, required: false 
    end
  end
end
