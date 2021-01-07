require 'test_helper'

class Queries::ServiceRequestTest < ActionDispatch::IntegrationTest
  test 'should get all requests as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_service_requests_helper }

    assert_response :success
    assert_equal ServiceRequest.count, json['data']['indexServiceRequests'].size
  end

  test 'should get any request as driver' do
    graphql_as_driver

    post graphql_path, params: { query: show_service_request_helper(service_requests(:one).id) }

    assert_response :success
    assert_equal service_requests(:one).id, json['data']['showServiceRequest']['id'].to_i
  end
end
