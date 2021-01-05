require 'test_helper'

class Mutations::AddressTest < ActionDispatch::IntegrationTest
  test 'cannot create address for another user as customer' do
    graphql_as_customer

    post graphql_path, params: { query: add_address_helper(users(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'can create own address as customer' do
    graphql_as_customer

    assert_difference('Address.count') do
      VCR.use_cassette('graphql customer add address') do
        post graphql_path, params: { query: add_address_helper(users(:three).id) }
      end
    end

    assert_response :success
    assert_not_nil Address.last.latitude
    assert_not_nil Address.last.longitude
  end

  test 'cannot update another address as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_address_helper(addresses(:one).id) }

    assert_response :success
    assert_equal json['errors'][0]['message'], Message.unauthorized
  end

  test 'can update own address as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_address_helper(addresses(:two).id) }

    assert_response :success
    assert_equal addresses(:two).reload.name, json['data']['updateAddress']['address']['name']
  end
end
