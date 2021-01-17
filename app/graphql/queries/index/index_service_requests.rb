# frozen_string_literal: true

module Queries
  module Index
    class IndexServiceRequests < Queries::BaseQuery
      type [Types::Api::ServiceRequestType], null: false

      def resolve
        check_logged_in_user

        return_for_admin_driver_or_owner(ServiceRequest)
      end
    end
  end
end
