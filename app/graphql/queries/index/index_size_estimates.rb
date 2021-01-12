# frozen_string_literal: true

module Queries
  module Index
    class IndexSizeEstimates < Queries::BaseQuery
      type [Types::SizeEstimateType], null: false

      def resolve
        check_logged_in_user

        SizeEstimate.all.order(created_at: :asc)
      end
    end
  end
end
