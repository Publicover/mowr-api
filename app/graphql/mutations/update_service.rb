# frozen_string_literal: true

module Mutations
  class UpdateService < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::ServiceInputType, required: true

    field :service, Types::ServiceType, null: false

    def ready?(**_args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:, params:)
      check_logged_in_user

      service_params = Hash(params)
      service = Service.find(id)

      if service.update(service_params)
        { service: service }
      else
        { errors: service.errors.full_messages }
      end
    end
  end
end
