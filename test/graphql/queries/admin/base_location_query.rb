require 'test_helper'

class Queries::BaseLocationTest < ActionDispatch::IntegrationTest
  test 'should get all location as admin' do
    graphql_as_admin

    post graphql_path, params: { query: index_base_locations_helper }

    assert_response :success
    assert_equal BaseLocation.count, json['data'].size
  end

  test 'should get single location as admin' do
    graphql_as_admin

    post graphql_path, params: { query: show_base_location_helper(base_locations(:one).id) }

    assert_response :success
    assert_equal base_locations(:one).id, json['data']['showBaseLocation']['id'].to_i
  end
end
