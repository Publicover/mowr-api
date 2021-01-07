# frozen_string_literal: true

module Queries
  class ShowServiceDelivery < Queries::BaseQuery
    type Types::ServiceDeliveryType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

      ServiceDelivery.find(id)
    end
  end
end
