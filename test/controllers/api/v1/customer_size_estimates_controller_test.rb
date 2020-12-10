require 'test_helper'

class CustomerSizeEstimatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
    @address = @user.addresses.last
    @size_estimate = @address.size_estimate
  end

  test 'should not get index as customer' do
    get api_v1_size_estimates_path, headers: @authorized_headers
    assert_match json['message'], Message.unauthorized
  end

  test 'should get own size estimate as customer' do
    get api_v1_size_estimate_path(@size_estimate), headers: @authorized_headers
    assert_response :success
    assert_equal @user.addresses.last.id, json['data']['id'].to_i
  end

  test 'should create own size estimate as customer' do
    address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                    state: Faker::Address.state, zip: Faker::Address.zip_code,
                    user_id: @user.id)
    post api_v1_size_estimates_path, params: {
      size_estimate: { acreage: 4.75, address_id: address.id }
      }.to_json,
      headers: @authorized_headers
    assert_response :success
    assert 4.75, address.size_estimate.reload.acreage
  end

  test 'should update own size estimate as customer' do
    patch api_v1_size_estimate_path(@size_estimate),
      params: { size_estimate: { acreage: 12.99 } }.to_json,
      headers: @authorized_headers
    assert_response :success
    assert_equal 12.99, @size_estimate.reload.acreage
  end

  test 'should destroy own size estimate as customer' do
    estimate_count = SizeEstimate.count
    delete api_v1_size_estimate_path(@size_estimate), headers: @authorized_headers
    assert_response :success
    assert_equal SizeEstimate.count, estimate_count - 1
  end
end
