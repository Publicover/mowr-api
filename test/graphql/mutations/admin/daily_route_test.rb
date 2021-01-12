require 'test_helper'

class Mutations::DailyRouteTest < ActionDispatch::IntegrationTest
  test 'should create daily route as admin' do
    graphql_as_admin

    assert_difference('DailyRoute.count') do
      post graphql_path, params: { query: create_daily_route_helper }
    end
  end

  test 'should update daily route as admin' do
    route = daily_routes(:one)
    graphql_as_admin

    post graphql_path, params: { query: update_daily_route_helper(route.id) }

    assert_response :success
    assert_equal route.reload.addresses_in_order, json['data']['updateDailyRoute']['dailyRoute']['addressesInOrder']
  end

  test 'should destroy daily route as admin' do
    graphql_as_admin
    route = daily_routes(:one)

    assert_difference('DailyRoute.count', -1) do
      post graphql_path, params: { query: destroy_daily_route_helper(route.id)}
    end
  end
end
