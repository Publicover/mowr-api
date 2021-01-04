# frozen_string_literal: true

module Queries
  class FetchUsers < Queries::BaseQuery
    type [Types::UserType], null: false

    def resolve
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      @users = User.all.order(created_at: :asc)

      authorized?
      
      @users
    end
  end
end
