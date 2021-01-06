require 'test_helper'

class Queries::SizeEstimateTest < ActionDispatch::IntegrationTest
  test 'should not get all estimates as driver' do
    graphql_as_driver

    post graphql_path, params: { query: fetch_size_estimates }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get any estimates as driver' do
    post graphql_path, params: { query: fetch_size_estimates(size_estimates(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
