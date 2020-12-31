# frozen_string_literal: true

module Types
  module Input
    class AuthUserInputType < Types::BaseInputObject
      argument :email, String, required: true
      argument :password, String, required: true
    end
  end
end
