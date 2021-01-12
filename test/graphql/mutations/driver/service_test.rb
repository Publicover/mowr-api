require 'test_helper'

class Mutations::ServiceTest < ActionDispatch::IntegrationTest
  test 'should not add service as driver' do
    graphql_as_driver

    post graphql_path, params: { query: add_service_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update any any service as driver' do
    graphql_as_driver

    post graphql_path, params: { query: update_service_helper(services(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy service as driver' do
    graphql_as_driver

    post graphql_path, params: { query: destroy_service_helper(services(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end