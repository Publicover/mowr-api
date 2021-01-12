require 'test_helper'

class Mutations::SizeEstimateTest < ActionDispatch::IntegrationTest
  setup do
    populate_blank_address
  end

  test 'should create size estimate as admin' do
    graphql_as_admin

    assert_difference('SizeEstimate.count') do
      post graphql_path, params: { query: create_size_estimate_helper(@address.id) }
    end
    assert_response :success
  end

  test 'should update any size estimate as admin' do
    area = 900
    graphql_as_admin

    post graphql_path, params: { query: update_size_estimate_helper(size_estimates(:one).id, area) }

    assert_response :success
    assert_equal size_estimates(:one).reload.square_footage, area
  end

  test 'should destroy size estimate as admin' do
    estimate = size_estimates(:two)
    graphql_as_admin

    post graphql_path, params: { query: destroy_size_estimate_helper(estimate.id) }

    assert_response :success
    assert_equal Message.is_deleted(estimate), json['data']['destroySizeEstimate']['isDeleted']
  end
end
