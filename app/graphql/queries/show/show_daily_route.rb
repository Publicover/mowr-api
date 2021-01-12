# frozen_string_literal: true

module Queries
  module Show
    class ShowDailyRoute < Queries::BaseQuery
      type Types::DailyRouteType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        DailyRoute.find(id)
      end
    end
  end
end
