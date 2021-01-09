require 'test_helper'

class Mutations::SizeEstimateTest < ActionDispatch::IntegrationTest
  setup do
    populate_blank_address
  end

  test 'should not get estimates as driver' do
    graphql_as_driver

    post graphql_path, params: { query: add_size_estimate_helper(@address.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get single estimate as driver' do
    graphql_as_driver

    post graphql_path, params: { query: update_size_estimate_helper(size_estimates(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not destroy size estimate as driver' do
    estimate = size_estimates(:one)
    graphql_as_driver

    post graphql_path, params: { query: destroy_size_estimate_helper(estimate.id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

end
