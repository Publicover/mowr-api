require 'test_helper'

class Queries::EarlyBirdTest < ActionDispatch::IntegrationTest
  test 'should not get size estimates as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_size_estimates_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should only get own size estimate as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_size_estimate_helper(size_estimates(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']

    post graphql_path, params: { query: show_size_estimate_helper(size_estimates(:two).id) }

    assert_response :success
    assert_equal size_estimates(:two).id, json['data']['showSizeEstimate']['id'].to_i
  end
end
