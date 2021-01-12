# frozen_string_literal: true

module Queries
  module Index
    class IndexServiceRequests < Queries::BaseQuery
      type [Types::ServiceRequestType], null: false

      def resolve
        check_logged_in_user

        ServiceRequest.all.order(created_at: :asc)
      end
    end
  end
end
