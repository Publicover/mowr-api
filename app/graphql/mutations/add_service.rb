# frozen_string_literal: true

module Mutations
  class AddService < Mutations::BaseMutation
    argument :params, Types::Input::ServiceInputType, required: true

    field :service, Types::ServiceType, null: false

    def ready(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      service_params = Hash(params)

      begin
        service = Service.create!(service_params)

        { service: service }

      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
