# frozen_string_literal: true

module Types
  module Input
    class AddressInputType < Types::BaseInputObject
      argument :line1, String, required: false
      argument :line2, String, required: false
      argument :city, String, required: false
      argument :state, String, required: false
      argument :zip, String, required: false
      argument :name, String, required: false
      argument :driveway, Integer, required: false
      argument :user_id, ID, required: false
    end
  end
end
