# frozen_string_literal: true

module Mutations
  module Destroy
    class DestroyEarlyBird < Mutations::BaseMutation
      argument :id, ID, required: true

      field :is_deleted, String, null: true

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].early_birds.pluck(:id).include?(args[:id].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:)
        check_logged_in_user

        early_bird = EarlyBird.find(id)

        early_bird.destroy

        { is_deleted: Message.is_deleted(early_bird).to_s }
      end
    end
  end
end
