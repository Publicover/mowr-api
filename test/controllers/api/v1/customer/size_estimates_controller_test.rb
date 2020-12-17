require 'test_helper'

class Api::V1::Customer::SizeEstimatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
    @address = @customer.addresses.last
    @size_estimate = @address.size_estimate
  end

  test 'should get own records as customer' do
    get api_v1_customer_service_requests_path, headers: @customer_headers
    assert_response :success
    assert_equal @customer.service_requests.count, json['data'].size
  end

  test 'should get own size estimate as customer' do
    get api_v1_customer_size_estimate_path(@size_estimate), headers: @customer_headers
    assert_response :success
    assert_equal @customer.addresses.last.id, json['data']['id'].to_i
  end

  test 'should create own size estimate and change parent address as customer' do
    address = Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                    state: Faker::Address.state, zip: Faker::Address.zip_code,
                    user_id: @customer.id, latitude: Faker::Address.latitude,
                    longitude: Faker::Address.longitude, name: Faker::Company.name)
    post api_v1_customer_size_estimates_path, params: {
      size_estimate: { square_footage: 74.75, address_id: address.id }
      }.to_json,
      headers: @customer_headers
    assert_response :success
    assert 74.75, address.size_estimate.reload.square_footage
    assert address.reload.estimate_complete
  end

  test 'should update own size estimate as customer' do
    patch api_v1_customer_size_estimate_path(@size_estimate),
      params: { size_estimate: { square_footage: 122.99 } }.to_json,
      headers: @customer_headers
    assert_response :success
    assert_equal 122.99, @size_estimate.reload.square_footage
  end

  test 'should destroy own size estimate as customer' do
    estimate_count = SizeEstimate.count
    delete api_v1_customer_size_estimate_path(@size_estimate), headers: @customer_headers
    assert_response :success
    assert_equal SizeEstimate.count, estimate_count - 1
  end
end
