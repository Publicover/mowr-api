require 'test_helper'

class Mutations::AddressTest < ActionDispatch::IntegrationTest
  test 'can create any address as admin' do
    graphql_as_admin

    assert_difference('Address.count') do
      VCR.use_cassette('graphql admin add address') do
        post graphql_path, params: { query: create_address_helper(users(:three).id) }
      end
    end

    assert_response :success
    assert_not_nil Address.last.latitude
    assert_not_nil Address.last.longitude
  end

  test 'can update any address as admin' do
    name = Faker::Lorem.word
    graphql_as_admin

    post graphql_path, params: { query: update_address_helper(addresses(:one).id, name) }

    assert_response :success
    assert_equal addresses(:one).reload.name, name
  end

  test 'can destroy any address as admin' do
    address = addresses(:one)
    graphql_as_admin

    post graphql_path, params: { query: destroy_address_helper(address.id) }

    assert_response :success
    assert_equal Message.is_deleted(address), json['data']['destroyAddress']['isDeleted']
  end
end
