# frozen_string_literal: true

module Mutations
  module Update
    class UpdateUser < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::UserInputType, required: true

      field :user, Types::Api::UserType, null: false

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].id == args[:id].to_i

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:, params:)
        check_logged_in_user

        user_params = Hash(params)
        user = User.find(id)
        user.update(user_params)

        { user: user }
      end
    end
  end
end
