require 'test_helper'

class Queries::DailyRouteTest < ActionDispatch::IntegrationTest
  test 'should get all routes as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_daily_routes_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should get single route as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_daily_route_helper(daily_routes(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
