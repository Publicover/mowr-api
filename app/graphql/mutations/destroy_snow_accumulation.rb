# frozen_string_literal: true

module Mutations
  class DestroySnowAccumulation < Mutations::BaseMutation
    argument :id, ID, required: true

    field :is_deleted, String, null: true

    def ready?(**_args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:)
      check_logged_in_user

      snow_accumulation = SnowAccumulation.find(id)

      snow_accumulation.destroy

      { is_deleted: Message.is_deleted(snow_accumulation).to_s }
    end
  end
end
