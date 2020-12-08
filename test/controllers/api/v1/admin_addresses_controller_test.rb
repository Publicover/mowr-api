require 'test_helper'

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_new_admin
    5.times do
      Address.create!(line_1: Faker::Address.street_address, city: Faker::Address.city,
                      state: Faker::Address.state, zip: Faker::Address.zip_code,
                      user_id: [User.first.id, User.last.id].sample)
    end
    @address = Address.where.not(user_id: @user.id).sample
  end

  test 'should not get index without headers' do
    get api_v1_addresses_path(@address.user), headers: @headers
    assert_equal Message.missing_token, json['message']
  end

  test 'should respond with standard message if address does not exist' do
    get api_v1_address_path(id: Address.last.id + 1), headers: @authorized_headers
    assert_equal "Couldn't find Address with 'id'=#{Address.last.id + 1}", json['message']
  end

  test 'should get index of all addresses' do
    # TODO
    # OK, in this test and this test only, the admin user would become the
    # customer user immediately upon completing the setup method. No idea why.
    # It only happened when the full test suite was run so there's a db problem somewhere
    # but I can't find it after several hours. It works if you just put the whole method here.

    @user = User.create(email: 'test_admin@mowr.com',
                        f_name: 'Jim',
                        l_name: 'Pub',
                        password: 'password',
                        password_confirmation: 'password',
                        role: :admin)
    @headers = valid_headers(@user.id).except('Authorization')
    @valid_creds = { email: @user.email, password: @user.password }.to_json
    @invalid_creds = { email: Faker::Internet.email, password: Faker::Internet.password }.to_json
    post auth_login_path, headers: @headers, params: @valid_creds
    @authorized_headers = {
      "Content-Type" => 'application/json',
      'Authorization' => "#{json['auth_token']}",
      'Accepts' => 'application/json'
    }

    get api_v1_addresses_path, headers: @authorized_headers
    assert_response :success
    assert_equal Address.count, json['data'].size
  end

  test 'should show any address' do
    get api_v1_address_path(@address), headers: @authorized_headers
    assert_response :success
  end

  test 'should create any address' do
    assert_difference('Address.count') do
      post api_v1_addresses_path,
           params: {
             address: {
               line_1: '234 Test Ave',
               city: 'Ashtabula',
               state: 'Ohio',
               zip: '44004',
               user_id: User.last.id
             }
           }.to_json,
           headers: @authorized_headers
    end
    assert_response :success
  end

  test 'should update any address' do
    patch api_v1_address_path(@address),
      params: { address: { city: 'Shropinshire Upon Avon' } }.to_json,
      headers: @authorized_headers
    assert_response :success
    assert_equal 'Shropinshire Upon Avon', @address.reload.city
  end

  test 'should delete any address' do
    address_count = Address.count
    delete api_v1_address_path(@address), headers: @authorized_headers
    assert_response :success
    assert_equal Address.count, address_count - 1
  end
end
