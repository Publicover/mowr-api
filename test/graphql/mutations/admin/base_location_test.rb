require 'test_helper'

class Mutations::BaseLocationTest < ActionDispatch::IntegrationTest
  test 'can create location as admin' do
    graphql_as_admin

    assert_difference('BaseLocation.count') do
      VCR.use_cassette('base location graphql admin') do
        post graphql_path, params: { query: create_base_location_helper }
      end
    end

    assert_response :success
    assert_not_nil BaseLocation.last.latitude
    assert_not_nil BaseLocation.last.longitude
  end

  test 'can update location as admin' do
    name = Faker::Lorem.word
    graphql_as_admin

    post graphql_path, params: { query: update_base_location_helper(base_locations(:one).id, name) }

    assert_response :success
    assert_equal base_locations(:one).reload.name, name
  end

  test 'can destroy location as admin' do
    graphql_as_admin

    assert_difference('BaseLocation.count', -1) do
      post graphql_path, params: { query: destroy_base_location_helper(base_locations(:one).id) }
    end
  end
end
