require 'test_helper'

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  require 'test_helper'

  class AuthenticationControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = User.create(email: 'jim@home.com', f_name: 'Jim', l_name: 'Pub',
                          password: 'password', password_confirmation: 'password',
                          role: :admin, phone: '3334445555')
      @headers = valid_headers(@user.id).except('Authorization')
      @valid_creds = { email: @user.email, password: @user.password }.to_json
      @invalid_creds = { email: Faker::Internet.email, password: Faker::Internet.password }.to_json
    end

    test 'when request is valid' do
      post auth_login_path, headers: @headers, params: @valid_creds
      assert_not_nil json['auth_token']
    end

    test 'when request is invalid' do
      post auth_login_path, headers: @headers, params: @invalid_creds
      assert_match json['message'], Message.invalid_credentials
    end
  end

end
