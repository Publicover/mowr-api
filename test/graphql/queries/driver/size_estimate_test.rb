require 'test_helper'

class Queries::SizeEstimateTest < ActionDispatch::IntegrationTest
  test 'should not get all estimates as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_size_estimates_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get any estimates as driver' do
    graphql_as_driver
    
    post graphql_path, params: { query: show_size_estimate_helper(size_estimates(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
