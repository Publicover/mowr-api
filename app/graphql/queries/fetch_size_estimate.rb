# frozen_string_literal: true

module Queries
  class FetchSizeEstimate < Queries::BaseQuery
    type Types::SizeEstimateType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end
      
      SizeEstimate.find(id)
    end
  end
end
