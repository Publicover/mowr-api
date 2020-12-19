require 'test_helper'

class Api::V1::Customer::AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
    5.times do
      Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                      state: Faker::Address.state, zip: Faker::Address.zip_code,
                      user_id: @driver.id, latitude: Faker::Address.latitude,
                      longitude: Faker::Address.longitude, name: Faker::Company.name,
                      driveway: [:small, :medium, :large].sample)
    end
    @address = @driver.addresses.sample
    @size_estimate = SizeEstimate.create!(address_id: @address.id, square_footage: 100.0)
  end

  test "should get any address as driver" do
    get api_v1_driver_addresses_path, headers: @driver_headers
    assert_response :success
    assert_equal Address.count, json['data'].size
  end

  test 'should get any record as driver' do
    get api_v1_driver_address_path(@address), headers: @driver_headers
    assert_response :success
  end

  test "should update any record as driver" do
    patch api_v1_driver_address_path(@address),
      params: { address: { city: 'Shropinshire Upon Avon' } }.to_json,
      headers: @driver_headers
    assert_response :success
    assert_equal 'Shropinshire Upon Avon', @address.reload.city
  end

  # test 'should flip enum on size estimate when confirming estimate' do
  #   patch api_v1_driver_address_path(@address),
  #     params: { address: { estimate_confirmed: true } }.to_json,
  #     headers: @driver_headers
  #   # puts @address.size_estimate.reload.inspect
  #   assert @address.reload.size_estimate.reload.confirmed?
  # end

  test 'should not delete record as driver' do
    user_address_count = @driver.addresses.count
    address_count = Address.count
    delete api_v1_driver_address_path(@address), headers: @driver_headers
    assert_match Message.unauthorized, json['message']
    assert_equal Address.count, address_count
  end
end
