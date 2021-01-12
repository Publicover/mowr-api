# frozen_string_literal: true

module Mutations
  module Create
    class CreateDailyRoute < Mutations::BaseMutation
      argument :params, Types::Input::DailyRouteInputType, required: true

      field :daily_route, Types::Api::DailyRouteType, null: false

      def ready?(**args)
        error_unless_admin
      end

      def resolve(params:)
        check_logged_in_user

        daily_route_params = Hash(params)
        daily_route = DailyRoute.create!(daily_route_params)

        { daily_route: daily_route }
      end
    end
  end
end
