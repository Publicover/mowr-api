# frozen_string_literal: true

module DailyRoutesQuery
  def index_daily_routes_helper
    <<~GQL
      query {
        indexDailyRoutes {
          id
          addressesInOrder
        }
      }
    GQL
  end

  def show_daily_route_helper(id)
    <<~GQL
      query {
        showDailyRoute(id:#{id}) {
          id
          addressesInOrder
        }
      }
    GQL
  end
end
