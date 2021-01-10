require 'test_helper'

class Queries::PlowTest < ActionDispatch::IntegrationTest
  test 'should get all plows as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_plows_helper }

    assert_response :success
    assert_equal Plow.count, json['data']['indexPlows'].size
  end

  test 'should get single plow as driver' do
    graphql_as_driver

    post graphql_path, params: { query: show_plow_helper(plows(:one).id) }

    assert_response :success
    assert_equal plows(:one).id, json['data']['showPlow']['id'].to_i
  end
end
