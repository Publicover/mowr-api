require 'test_helper'

class Mutations::BaseLocationTest < ActionDispatch::IntegrationTest
  test 'should not create location as customer' do
    graphql_as_customer

    post graphql_path, params: { query: add_base_location_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update location as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_base_location_helper(base_locations(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy location as customer' do
    graphql_as_customer

    post graphql_path, params: { query: destroy_base_location_helper(base_locations(:one).id) }

    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
