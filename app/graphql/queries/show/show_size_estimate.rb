# frozen_string_literal: true

module Queries
  module Show
    class ShowSizeEstimate < Queries::BaseQuery
      type Types::Api::SizeEstimateType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        SizeEstimate.find(id)
      end
    end
  end
end
