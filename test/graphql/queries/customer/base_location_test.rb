require 'test_helper'

class Queries::BaseLocationTest < ActionDispatch::IntegrationTest
  test 'should not get location as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_base_locations_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get single location as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_base_location_helper(base_locations(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
