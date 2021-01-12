# frozen_string_literal: true

module Mutations
  module Destroy
    class DestroyAddress < Mutations::BaseMutation
      argument :id, ID, required: true

      field :is_deleted, String, null: true

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].addresses.pluck(:id).include?(args[:id].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:)
        check_logged_in_user

        address = Address.find(id)

        address.destroy

        { is_deleted: Message.is_deleted(address).to_s }
      end
    end
  end
end
