# frozen_string_literal: true

module Types
  module Input
    class SnowAccumulationInputType < Types::BaseInputObject
      argument :inches, Integer, required: false
    end
  end
end
