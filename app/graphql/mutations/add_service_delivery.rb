# frozen_string_literal: true

module Mutations
  class AddServiceDelivery < Mutations::BaseMutation
    argument :params, Types::Input::ServiceDeliveryInputType, required: true

    field :service_delivery, Types::ServiceDeliveryType, null: false

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      service_delivery_params = Hash(params)

      begin
        service_delivery = ServiceDelivery.create!(service_delivery_params)
        address = service_delivery.address

        { service_delivery: service_delivery, address: address }

      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")

      end
    end
  end
end
