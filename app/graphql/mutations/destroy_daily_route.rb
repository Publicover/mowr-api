# frozen_string_literal: true

module Mutations
  class DestroyDailyRoute < Mutations::BaseMutation
    argument :id, ID, required: true

    field :is_deleted, String, null: true

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:)
      check_logged_in_user

      daily_route = DailyRoute.find(id)

      daily_route.destroy

      { is_deleted: Message.is_deleted(daily_route).to_s }
    end
  end
end
