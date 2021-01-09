# frozen_string_literal: true

module Mutations
  class AddAddress < Mutations::BaseMutation
    argument :params, Types::Input::AddressInputType, required: true

    field :address, Types::AddressType, null: false

    def ready?(**args)
      raise GraphQL::ExecutionError, Message.unauthorized if context[:current_user].driver?
      raise GraphQL::ExecutionError, Message.unauthorized unless
            context[:current_user].admin? || args[:params][:userId] == context[:current_user].id.to_s

      true
    end

    def resolve(params:)
      check_logged_in_user

      address_params = Hash(params)

      begin
        address = Address.create!(address_params)

        { address: address }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
