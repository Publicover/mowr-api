# frozen_string_literal: true

module Queries
  class FetchServiceRequests < Queries::BaseQuery
    type [Types::ServiceRequestType], null: false

    def resolve
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      ServiceRequest.all.order(created_at: :asc)
    end
  end
end
