require 'test_helper'

class AuthenticateUserTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(email: 'jim@home.com', f_name: 'Jim', l_name: 'Pub', password: 'password', role: :admin)
    @valid_auth = AuthenticateUser.new(@user.email, @user.password)
    @invalid_auth = AuthenticateUser.new('bad', 'creds')
  end

  test 'call with valid credentials' do
    token = @valid_auth.call
    refute_nil token
  end

  test 'call with invalid credentials' do
    assert_raises ExceptionHandler::AuthenticationError do
      @invalid_auth.call
    end
  end

  test 'can log in with short method' do
    user = users(:one)
    @valid_creds = { email: user.email, password: 'password' }.to_json
    post auth_login_path, headers: unauthorized_headers, params: @valid_creds
    @authorized_headers = unauthorized_headers.merge('Authorization' => "#{json['auth_token']}")
    get api_v1_users_path, headers: @authorized_headers
    assert_response :success
  end
end
