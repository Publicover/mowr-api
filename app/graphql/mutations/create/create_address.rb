# frozen_string_literal: true

module Mutations
  module Create
    class CreateAddress < Mutations::BaseMutation
      argument :params, Types::Input::AddressInputType, required: true

      field :address, Types::AddressType, null: false

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].customer? &&
                       args[:params][:userId] == context[:current_user].id.to_s

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(params:)
        check_logged_in_user

        address_params = Hash(params)
        address = Address.create!(address_params)

        { address: address }
      end
    end
  end
end
