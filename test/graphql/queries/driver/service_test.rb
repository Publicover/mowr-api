require 'test_helper'

class Queries::ServiceTest < ActionDispatch::IntegrationTest
  test 'should return all services as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_services_helper }

    assert_response :success
    assert_equal Service.count, json['data']['indexServices'].size
  end

  test 'should return single service as driver' do
    graphql_as_driver

    post graphql_path, params: { query: show_service_helper(services(:one).id) }

    assert_response :success
    assert_equal services(:one).id, json['data']['showService']['id'].to_i
  end
end
