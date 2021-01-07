require 'test_helper'

class Queries::AddressTest < ActionDispatch::IntegrationTest
  test 'should get all addresses as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_addresses_helper }

    assert_response :success
    assert_equal Address.count, json['data']['indexAddresses'].size
  end

  test 'should get any address as driver' do
    graphql_as_driver

    post graphql_path, params: { query: show_address_helper(Address.first.id) }

    assert_response :success
    assert_equal Address.first.id, json['data']['showAddress']['id'].to_i

    post graphql_path, params: { query: show_address_helper(Address.last.id) }

    assert_response :success
    assert_equal Address.last.id, json['data']['showAddress']['id'].to_i
  end
end
