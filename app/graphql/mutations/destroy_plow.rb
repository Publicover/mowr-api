# frozen_string_literal: true

module Mutations
  class DestroyPlow < Mutations::BaseMutation
    argument :id, ID, required: true

    field :is_deleted, String, null: true

    def ready?(**_args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:)
      check_logged_in_user

      plow = Plow.find(id)

      plow.destroy

      { is_deleted: Message.is_deleted(plow) }
    end
  end
end
