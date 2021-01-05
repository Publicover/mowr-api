# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :auth_user, mutation: Mutations::AuthUser
    field :add_user, mutation: Mutations::AddUser
    field :update_user, mutation: Mutations::UpdateUser
    field :add_address, mutation: Mutations::AddAddress
    field :update_address, mutation: Mutations::UpdateAddress
  end
end
