require 'test_helper'

class Queries::ServiceTest < ActionDispatch::IntegrationTest
  test 'should return all services as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_services_helper }

    assert_response :success
    assert_equal Service.count, json['data']['fetchServices'].size
  end

  test 'should return single service as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_service_helper(services(:one).id) }

    assert_response :success
    assert_equal services(:one).id, json['data']['fetchService']['id'].to_i
  end
end
