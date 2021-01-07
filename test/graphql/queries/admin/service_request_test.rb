require 'test_helper'

class Queries::ServiceRequestTest < ActionDispatch::IntegrationTest
  test 'should get all requests as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_service_requests_helper }

    assert_response :success
    assert_equal ServiceRequest.count, json['data']['fetchServiceRequests'].size
  end

  test 'should get any request as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_service_request_helper(service_requests(:one).id) }

    assert_response :success
    assert_equal service_requests(:one).id, json['data']['fetchServiceRequest']['id'].to_i
  end
end
