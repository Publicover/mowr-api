# frozen_string_literal: true

module Mutations
  class DestroyService < Mutations::BaseMutation
    argument :id, ID, required: true

    field :is_deleted, String, null: true

    def ready?(**_args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:)
      check_logged_in_user

      service = Service.find(id)

      service.destroy

      { is_deleted: Message.is_deleted(service).to_s }
    end
  end
end
