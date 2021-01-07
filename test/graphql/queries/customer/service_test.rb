require 'test_helper'

class Queries::ServiceTest < ActionDispatch::IntegrationTest
  test 'should return all services as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_services_helper }

    assert_response :success
    assert_equal Service.count, json['data']['indexServices'].size
  end

  test 'should return single service as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_service_helper(services(:one).id) }

    assert_response :success
    assert_equal services(:one).id, json['data']['showService']['id'].to_i
  end
end
