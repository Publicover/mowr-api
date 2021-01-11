require 'test_helper'

class Mutations::DailyRouteTest < ActionDispatch::IntegrationTest
  test 'should create daily route as driver' do
    graphql_as_driver

    post graphql_path, params: { query: add_daily_route_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update daily route as driver' do
    route = daily_routes(:one)
    graphql_as_driver

    post graphql_path, params: { query: update_daily_route_helper(route.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy daily route as driver' do
    graphql_as_driver
    route = daily_routes(:one)

    post graphql_path, params: { query: destroy_daily_route_helper(route.id)}

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
