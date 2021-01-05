require 'test_helper'

class Mutations::AddressTest < ActionDispatch::IntegrationTest
  test 'cannot create address as driver' do
    graphql_as_driver

    post graphql_path, params: { query: add_address_helper(users(:two).id) }

    assert_response :success
    assert_equal json['errors'][0]['message'], Message.unauthorized
  end

  test 'cannot update address as driver' do
    graphql_as_driver

    post graphql_path, params: { query: update_address_helper(addresses(:two).id) }

    assert_response :success
    assert_equal json['errors'][0]['message'], Message.unauthorized
  end
end
