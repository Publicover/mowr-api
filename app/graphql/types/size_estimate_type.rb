# frozen_string_literal: true

module Types
  class SizeEstimateType < Types::BaseObject
    def self.authorized?(object, context)
      super && (context[:current_user].admin? ||
                object.user == context[:current_user])
    end
    field :id, ID, null: false
    field :square_footage, Float, null: false
    field :status, Integer, null: false
    field :address_id, ID, null: false
    field :address, Types::AddressType, null: false
  end
end
