require 'test_helper'

class Mutations::DailyRouteTest < ActionDispatch::IntegrationTest
  test 'should not create daily route as customer' do
    graphql_as_customer

    post graphql_path, params: { query: create_daily_route_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update daily route as customer' do
    route = daily_routes(:one)
    ary = [12, 121]
    graphql_as_customer

    post graphql_path, params: { query: update_daily_route_helper(route.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy daily route as customer' do
    graphql_as_customer
    route = daily_routes(:one)

    post graphql_path, params: { query: destroy_daily_route_helper(route.id)}

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
