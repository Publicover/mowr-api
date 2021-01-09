require 'test_helper'

class Api::V1::Admin::AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
    5.times do
      Address.create!(line1: Faker::Address.street_address, city: Faker::Address.city,
                      state: Faker::Address.state, zip: Faker::Address.zip_code,
                      user_id: [User.first.id, User.last.id].sample,
                      latitude: Faker::Address.latitude, longitude: Faker::Address.longitude,
                      name: Faker::Company.name, driveway: [:small, :medium, :large].sample)
    end
    @address = Address.where.not(user_id: @admin.id).sample
  end

  test 'should not get index without headers' do
    get api_v1_admin_addresses_path(@address.user), headers: @headers
    assert_equal Message.missing_token, json['message']
  end

  test 'should respond with standard message if address does not exist' do
    get api_v1_admin_address_path(id: Address.last.id + 1), headers: @admin_headers
    assert_equal "Couldn't find Address with 'id'=#{Address.last.id + 1}", json['message']
  end

  test 'should get index of all addresses' do
    get api_v1_admin_addresses_path, headers: @admin_headers
    assert_response :success
    assert_equal Address.count, json['data'].size
  end

  test 'should show any address' do
    get api_v1_admin_address_path(@address), headers: @admin_headers
    assert_response :success
  end

  test 'should create any address' do
    VCR.use_cassette('api admin create address') do
      assert_difference('Address.count') do
        post api_v1_admin_addresses_path,
             params: {
               address: {
                 line1: '234 Test Ave',
                 city: 'Ashtabula',
                 state: 'Ohio',
                 zip: '44004',
                 user_id: User.last.id
               }
             }.to_json,
             headers: @admin_headers
      end
    end
    assert_response :success
  end

  test 'should update any address' do
    patch api_v1_admin_address_path(@address),
      params: { address: { city: 'Shropinshire Upon Avon' } }.to_json,
      headers: @admin_headers
    assert_response :success
    assert_equal 'Shropinshire Upon Avon', @address.reload.city
  end

  test 'should delete any address' do
    address_count = Address.count
    delete api_v1_admin_address_path(@address), headers: @admin_headers
    assert_response :success
    assert_equal Address.count, address_count - 1
  end
end
