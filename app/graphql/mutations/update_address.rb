# frozen_string_literal: true

module Mutations
  class UpdateAddress < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::AddressInputType, required: true

    field :address, Types::AddressType, null: false

    def ready?(**args)
      raise GraphQL::ExecutionError, Message.unauthorized if context[:current_user].driver?
      raise GraphQL::ExecutionError, Message.unauthorized if
            (context[:current_user].customer? && !context[:current_user].addresses.pluck(:id).include?(args[:params][:addressId].to_i))

      true
    end

    def resolve(id:, params:)
      address_params = Hash(params)
      address = Address.find(id)

      if address.update(address_params)
        { address: address }
      else
        { errors: address.errors.full_messages }
      end
    end
  end
end
