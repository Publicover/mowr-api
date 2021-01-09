# frozen_string_literal: true

module Mutations
  class DestroyUser < Mutations::BaseMutation
    argument :id, ID, required: true

    field :is_deleted, String, null: true

    def ready?(**args)
      return true if context[:current_user].admin?
      return true if context[:current_user].id == args[:id].to_i

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:)
      check_logged_in_user

      user = User.find(id)

      user.destroy

      { is_deleted: Message.is_deleted(user).to_s }
    end
  end
end
