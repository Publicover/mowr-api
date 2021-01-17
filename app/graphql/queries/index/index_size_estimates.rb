# frozen_string_literal: true

module Queries
  module Index
    class IndexSizeEstimates < Queries::BaseQuery
      type [Types::Api::SizeEstimateType], null: false

      def resolve
        check_logged_in_user

        return_for_admin_driver_or_owner(SizeEstimate)
      end
    end
  end
end
