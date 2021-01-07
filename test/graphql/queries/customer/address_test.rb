require 'test_helper'

class Queries::AddressTest < ActionDispatch::IntegrationTest
  test 'should not retrive all addresses as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_addresses_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should retrieve own record as customer' do
    user = users(:three)
    graphql_as_customer

    post graphql_path, params: { query: show_address_helper(user.addresses.first.id) }

    assert_response :success
    assert_equal user.addresses.first.id, json['data']['showAddress']['id'].to_i

    post graphql_path, params: { query: show_address_helper(users(:one).addresses.last.id) }

    assert_response :success
    assert_match Message.unauthorized, json['errors'][0]['message']
  end
end
