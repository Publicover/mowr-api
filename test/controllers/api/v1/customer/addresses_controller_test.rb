require 'test_helper'

class Api::V1::Customer::AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
    5.times do
      Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                      state: Faker::Address.state, zip: Faker::Address.zip_code,
                      user_id: @customer.id, latitude: Faker::Address.latitude,
                      longitude: Faker::Address.longitude, name: Faker::Company.name)
    end
    @address = @customer.addresses.sample
  end

  test "should get customer's addresses" do
    login_as_customer
    get api_v1_customer_addresses_path, headers: @customer_headers
    assert_response :success
    assert_equal @customer.addresses.count, json['data'].size
  end

  test 'should get single customer record' do
    get api_v1_customer_address_path(@address), headers: @customer_headers
    assert_response :success
    assert_equal @address.id, json['data']['id'].to_i
  end

  test "should update customer's record" do
    patch api_v1_customer_address_path(@address),
      params: { address: { city: 'New Testington' } }.to_json,
      headers: @customer_headers
    assert_response :success
    assert_equal 'New Testington', @address.reload.city
  end

  test "should delete customer's address" do
    # OK, so minitest has funky memory things going on. And it doesn't play well
    # with DatabaseCleaner either. This test will pass in isolation or when just
    # this file is run but it fails in the larger test suite. Logging in manually
    # without using the helper method does the job for some reason.
    @customer = users(:three)
    @valid_creds = { email: @customer.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @customer_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")

    assert_difference('Address.count', -1) do
      delete api_v1_customer_address_path(@address), headers: @customer_headers
    end
  end
end
