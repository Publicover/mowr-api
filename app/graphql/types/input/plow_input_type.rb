# frozen_string_literal: true

module Types
  module Input
    class PlowInputType < Types::BaseInputObject
      argument :licence_plate, String, required: false
      argument :year, String, required: false
      argument :color, String, required: false
      argument :make, String, required: false
      argument :model, String, required: false
      argument :user_id, Integer, required: false
    end
  end
end
