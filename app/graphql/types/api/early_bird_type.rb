# frozen_string_literal: true

module Types
  module Api
    class EarlyBirdType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
                  context[:current_user].driver? ||
                  object.user == context[:current_user])
      end
      field :id, ID, null: false
      field :priority, Integer, null: false
      field :address_id, ID, null: false
      field :address, Types::Api::AddressType, null: false
    end
  end
end
