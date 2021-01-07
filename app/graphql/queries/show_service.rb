# frozen_string_literal: true

module Queries
  class ShowService < Queries::BaseQuery
    type Types::ServiceType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      Service.find(id)
    end
  end
end
