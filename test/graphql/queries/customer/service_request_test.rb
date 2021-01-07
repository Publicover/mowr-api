require 'test_helper'

class Queries::ServiceRequestTest < ActionDispatch::IntegrationTest
  test 'should not get all requests as customer' do
    graphql_as_customer

    post graphql_path, params: { query: fetch_service_requests_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get another request as customer' do
    graphql_as_customer

    post graphql_path, params: { query: fetch_service_request_helper(service_requests(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should get own request as customer' do
    graphql_as_customer

    post graphql_path, params: { query: fetch_service_request_helper(service_requests(:two).id) }

    assert_response :success
    assert_equal service_requests(:two).id, json['data']['fetchServiceRequest']['id'].to_i
  end
end
