# frozen_string_literal: true

module Mutations
  class UpdateDailyRoute < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::DailyRouteInputType, required: true

    field :daily_route, Types::DailyRouteType, null: false

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:, params:)
      check_logged_in_user

      daily_route_params = Hash(params)
      daily_route = DailyRoute.find(id)

      if daily_route.update(daily_route_params)
        { daily_route: daily_route }
      else
        { errors: daily_route.errors.full_messages }
      end
    end
  end
end
