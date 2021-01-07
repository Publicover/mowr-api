# frozen_string_literal: true

module Queries
  class FetchServiceRequest < Queries::BaseQuery
    type Types::ServiceRequestType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      ServiceRequest.find(id)
    end
  end
end
