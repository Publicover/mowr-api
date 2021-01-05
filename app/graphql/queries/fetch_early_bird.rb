# frozen_string_literal: true

module Queries
  class FetchEarlyBird < Queries::BaseQuery
    type Types::EarlyBirdType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      EarlyBird.find(id)
    end
  end
end
