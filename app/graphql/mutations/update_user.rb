# frozen_string_literal: true

module Mutations
  class UpdateUser < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::UserInputType, required: true

    field :user, Types::UserType, null: false

    def resolve(id:, params:)
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      user_params = Hash(params)

      user = User.find(id)

      if user.update(user_params)
        if context[:current_user].admin? || user.id == context[:current_user].id
          { user: user }
        elsif context[:current_user].admin? || user.id == context[:current_user].id
          { user: user }
        else
          raise GraphQL::ExecutionError, Message.unauthorized
        end
      else
        { errors: user.errors.full_messages }
      end

      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
