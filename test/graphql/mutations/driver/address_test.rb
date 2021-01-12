require 'test_helper'

class Mutations::AddressTest < ActionDispatch::IntegrationTest
  test 'cannot create address as driver' do
    graphql_as_driver

    post graphql_path, params: { query: create_address_helper(users(:two).id) }

    assert_response :success
    assert_equal json['errors'][0]['message'], Message.unauthorized
  end

  test 'cannot update address as driver' do
    name = Faker::Lorem.word
    graphql_as_driver

    post graphql_path, params: { query: update_address_helper(addresses(:two).id, name) }

    assert_response :success
    assert_equal json['errors'][0]['message'], Message.unauthorized
  end

  test 'cannot delete address as driver' do
    graphql_as_driver

    post graphql_path, params: { query: destroy_address_helper(addresses(:two).id) }

    assert_response :success
    assert_equal json['errors'][0]['message'], Message.unauthorized
  end
end
