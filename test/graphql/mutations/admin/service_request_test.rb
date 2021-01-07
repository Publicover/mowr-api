require 'test_helper'

class Mutations::ServiceRequestTest < ActionDispatch::IntegrationTest
  setup do
    populate_blank_address
  end

  test 'should create request as admin' do
    graphql_as_admin

    assert_difference('ServiceRequest.count') do
      post graphql_path, params: { query: add_service_request_helper(@address.id) }
    end

    assert_response :success
  end

  test 'should update any early bird as admin' do
    graphql_as_admin

    post graphql_path, params: { query: update_service_request_helper(service_requests(:two).id, services(:one).id) }

    assert_response :success
    assert service_requests(:two).reload.service_ids, json['data']['updateServiceRequest']['serviceRequest']['serviceIds']
  end
end
