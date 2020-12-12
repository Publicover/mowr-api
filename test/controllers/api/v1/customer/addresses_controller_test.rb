require 'test_helper'

class Api::V1::Customer::AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
    5.times do
      Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                      state: Faker::Address.state, zip: Faker::Address.zip_code,
                      user_id: @user.id)
    end
    @address = @user.addresses.sample
  end

  test "should get customer's addresses" do
    get api_v1_customer_addresses_path, headers: @authorized_headers
    assert_response :success
    assert_equal @user.addresses.count, json['data'].size
  end

  test 'should get single customer record' do
    get api_v1_customer_address_path(@address), headers: @authorized_headers
    assert_response :success
    assert @user.addresses.include?(@address)
  end

  test "should update customer's record" do
    patch api_v1_customer_address_path(@address),
      params: { address: { city: 'New Testington' } }.to_json,
      headers: @authorized_headers
    assert_response :success
    assert_equal 'New Testington', @address.reload.city
  end

  test "should delete customer's address" do
    user_address_count = @user.addresses.count
    address_count = Address.count
    delete api_v1_customer_address_path(@address), headers: @authorized_headers
    assert_equal @user.reload.addresses.count, user_address_count - 1
    assert_equal Address.count, address_count - 1
  end
end
