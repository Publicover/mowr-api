require 'test_helper'

class Mutations::ServiceRequestTest < ActionDispatch::IntegrationTest
  setup do
    populate_blank_address
  end

  test 'should create request as admin' do
    graphql_as_admin

    assert_difference('ServiceRequest.count') do
      post graphql_path, params: { query: create_service_request_helper(@address.id) }
    end

    assert_response :success
  end

  test 'should update any request as admin' do
    graphql_as_admin

    post graphql_path, params: { query: update_service_request_helper(service_requests(:two).id, services(:one).id) }

    assert_response :success
    assert service_requests(:two).reload.service_ids, services(:one).id
  end

  test 'should destroy service request as admin' do
    service_request = service_requests(:two)
    graphql_as_customer

    post graphql_path, params: { query: destroy_service_request_helper(service_request.id) }

    assert_response :success
    assert_equal Message.is_deleted(service_request), json['data']['destroyServiceRequest']['isDeleted']
  end
end
