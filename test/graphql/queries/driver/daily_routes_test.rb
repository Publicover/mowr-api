require 'test_helper'

class Queries::DailyRouteTest < ActionDispatch::IntegrationTest
  test 'should get all routes as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_daily_routes_helper }

    assert_response :success
    assert_equal DailyRoute.count, json['data']['indexDailyRoutes'].size
  end

  test 'should get single route as driver' do
    graphql_as_driver

    post graphql_path, params: { query: show_daily_route_helper(daily_routes(:one).id) }

    assert_response :success
    assert_equal daily_routes(:one).id, json['data']['showDailyRoute']['id'].to_i
  end
end
