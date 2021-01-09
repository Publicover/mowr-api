require 'test_helper'

class Mutations::ServiceRequestTest < ActionDispatch::IntegrationTest
  setup do
    populate_blank_address
  end

  test 'should not create request as driver' do
    graphql_as_driver

    post graphql_path, params: { query: add_service_request_helper(@address.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update request as driver' do
    graphql_as_driver

    post graphql_path, params: { query: update_service_request_helper(service_requests(:one).id, services(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy request as driver' do
    request = service_requests(:one)
    graphql_as_driver

    post graphql_path, params: { query: destroy_service_request_helper(request.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
