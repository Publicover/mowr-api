require 'test_helper'

class Queries::ServiceRequestTest < ActionDispatch::IntegrationTest
  test 'should retrieve owned addresses as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_service_requests_helper }

    assert_response :success
    assert_equal users(:three).service_requests.count, json['data']['indexServiceRequests'].size
    assert ServiceRequest.count > users(:three).service_requests.count
  end


  test 'should not get another request as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_service_request_helper(service_requests(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should get own request as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_service_request_helper(service_requests(:two).id) }

    assert_response :success
    assert_equal service_requests(:two).id, json['data']['showServiceRequest']['id'].to_i
  end
end
