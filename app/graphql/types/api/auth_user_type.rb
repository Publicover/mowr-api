# frozen_string_literal: true

module Types
  module Api
    class AuthUserType < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :password, String, null: false
    end
  end
end
