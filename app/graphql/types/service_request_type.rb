# frozen_string_literal: true

module Types
  class ServiceRequestType < Types::BaseObject
    def self.authorized?(object, context)
      super && (context[:current_user].admin? ||
                context[:current_user].driver? ||
                object.user == context[:current_user])
    end
    field :id, ID, null: false
    field :status, Integer, null: true
    field :service_subtotal, Float, null: true
    field :service_ids, [Integer], null: true
    field :address_id, ID, null: true
    field :address, Types::AddressType, null: true
  end
end
