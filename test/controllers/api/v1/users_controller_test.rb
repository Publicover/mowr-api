require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: 'jim@home.com',
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
  end

  test 'should not get user info without auth_token' do
    get api_v1_users_path, headers: @headers
    assert_match json['message'], Message.missing_token
  end

  test 'should get index as admin' do
    get api_v1_users_path, headers: @authorized_headers
    assert_response :success
  end

  test 'should update user of choice as admin' do
    patch api_v1_user_path(@user), params: {
      target_id: User.last.id, user: { f_name: 'New Guy' }
    }.to_json, headers: @authorized_headers
    assert_response :success
    assert_equal 'New Guy', User.last.f_name
  end

  test 'should delete user of choice as admin' do
    user_count = User.count
    delete api_v1_user_path(@user), params: { target_id: User.last.id }.to_json, headers: @authorized_headers
    assert_response :success
    assert User.count, user_count - 1
  end
end
