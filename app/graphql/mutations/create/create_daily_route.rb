# frozen_string_literal: true

module Mutations
  module Create
    class CreateDailyRoute < Mutations::BaseMutation
      argument :params, Types::Input::DailyRouteInputType, required: false

      field :daily_route, Types::Api::DailyRouteType, null: false

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(params: nil)
        check_logged_in_user

        daily_route_params = Hash(params)
        if daily_route_params[:calculate_route].present?
          CalculateDailyRoute.new.call
          daily_route = DailyRoute.last
        else
          daily_route = DailyRoute.create!(daily_route_params)
        end

        { daily_route: daily_route }
      end
    end
  end
end
