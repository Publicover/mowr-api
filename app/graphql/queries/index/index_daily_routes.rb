# frozen_string_literal: true

module Queries
  module Index
    class IndexDailyRoutes < Queries::BaseQuery
      type [Types::Api::DailyRouteType], null: false

      def resolve
        check_logged_in_user

        DailyRoute.all.order(created_at: :asc)
      end
    end
  end
end
