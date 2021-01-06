# frozen_string_literal: true

module Queries
  class FetchSizeEstimates < Queries::BaseQuery
    type [Types::SizeEstimateType], null: false

    def resolve
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end
      
      SizeEstimate.all.order(created_at: :asc)
    end
  end
end
