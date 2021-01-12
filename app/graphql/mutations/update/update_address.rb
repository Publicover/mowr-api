# frozen_string_literal: true

module Mutations
  module Update
    class UpdateAddress < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::AddressInputType, required: true

      field :address, Types::AddressType, null: false

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].addresses.pluck(:id).include?(args[:id].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:, params:)
        check_logged_in_user

        address_params = Hash(params)
        address = Address.find(id)

        { address: address }
      end
    end
  end
end
