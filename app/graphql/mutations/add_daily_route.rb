# frozen_string_literal: true

module Mutations
  class AddDailyRoute < Mutations::BaseMutation
    argument :params, Types::Input::DailyRouteInputType, required: true

    field :daily_route, Types::DailyRouteType, null: false

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      check_logged_in_user

      daily_route_params = Hash(params)

      begin
        daily_route = DailyRoute.create!(daily_route_params)

        { daily_route: daily_route }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
