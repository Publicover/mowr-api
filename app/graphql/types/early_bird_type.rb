# frozen_string_literal: true

module Types
  class EarlyBirdType < Types::BaseObject
    def self.authorized?(object, context)
      super && (context[:current_user].admin? ||
                context[:current_user].driver?)
    end
    field :id, ID, null: false
    field :priority, Integer, null: false
    field :address_id, ID, null: false
    field :address, Types::AddressType, null: false
  end
end
