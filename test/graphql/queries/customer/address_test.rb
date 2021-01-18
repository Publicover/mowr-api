require 'test_helper'

class Queries::AddressTest < ActionDispatch::IntegrationTest
  test 'should retrieve owned addresses as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_addresses_helper }

    assert_response :success
    assert_equal users(:customer).addresses.count, json['data']['indexAddresses'].size
    assert Address.count > users(:customer).addresses.count
  end

  test 'should retrieve own record as customer' do
    user = users(:customer)
    graphql_as_customer

    post graphql_path, params: { query: show_address_helper(user.addresses.first.id) }

    assert_response :success
    assert_equal user.addresses.first.id, json['data']['showAddress']['id'].to_i

    post graphql_path, params: { query: show_address_helper(users(:admin).addresses.last.id) }

    assert_response :success
    assert_match Message.unauthorized, json['errors'][0]['message']
  end
end
