# frozen_string_literal: true

module Types
  class AuthUserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :password, String, null: false
    # field :auth_token, String, null: false
  end
end
