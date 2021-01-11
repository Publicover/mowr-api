require 'test_helper'

class Queries::SnowAccumulationsTest < ActionDispatch::IntegrationTest
  test 'should get snow accumulations as admin' do
    graphql_as_admin

    post graphql_path, params: { query: index_snow_accumulations_helper }

    assert_response :success
    assert_equal SnowAccumulation.count, json['data']['indexSnowAccumulations'].size
  end

  test 'should get single accumulation as admin' do
    graphql_as_admin

    post graphql_path, params: { query: show_snow_accumulations_helper(snow_accumulations(:one).id) }

    assert_response :success
    assert_equal snow_accumulations(:one).id, json['data']['showSnowAccumulation']['id'].to_i
  end
end
