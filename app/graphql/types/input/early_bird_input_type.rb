# frozen_string_literal: true

module Types
  module Input
    class EarlyBirdInputType < Types::BaseInputObject
      argument :priority, Integer, required: false
      argument :address_id, ID, required: false
    end
  end
end
