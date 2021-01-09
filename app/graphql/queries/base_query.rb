# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    def check_logged_in_user
      return if context[:session][:token] && context[:current_user]

      raise(ExceptionHandler::InvalidToken, Message.invalid_token)
    end
  end
end
