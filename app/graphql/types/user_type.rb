# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    def self.authorized?(object, context)
      super && (context[:current_user].admin? ||
                context[:current_user].driver? ||
                object.id == context[:current_user].id)
    end

    field :id, ID, null: false
    field :email, String, null: false
    field :f_name, String, null: false
    field :l_name, String, null: false
    field :password_digest, String, null: false
    field :role, Integer, null: false
    field :phone, String, null: false
    field :addresses, [Types::AddressType], null: false
  end
end
