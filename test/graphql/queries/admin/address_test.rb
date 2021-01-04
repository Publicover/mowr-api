require 'test_helper'

class Queries::AddressTest < ActionDispatch::IntegrationTest
  test 'should get all addresses as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_addresses_helper }

    assert_response :success
    assert_equal Address.count, json['data']['fetchAddresses'].size
  end

  test 'should get any address as admin' do
    graphql_as_admin

    post graphql_path, params: { query: fetch_address_helper(Address.first.id) }

    assert_response :success
    assert_equal Address.first.id, json['data']['fetchAddress']['id'].to_i

    post graphql_path, params: { query: fetch_address_helper(Address.last.id) }

    assert_response :success
    assert_equal Address.last.id, json['data']['fetchAddress']['id'].to_i
  end
end
