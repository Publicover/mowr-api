require 'test_helper'

class DriverUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_new_driver
  end

  test 'should not get index as driver' do
    get api_v1_users_path, headers: @authorized_headers
    assert_match json['message'], Message.invalid_credentials
  end

  test 'should show own record as driver' do
    get api_v1_user_path(@user), headers: @authorized_headers
    assert_response :success
  end

  test 'should update own record as driver' do
    patch api_v1_user_path(@user), params: { user: { f_name: 'New Name McGee' } }.to_json, headers: @authorized_headers
    assert_response :success
    assert_equal 'New Name McGee', @user.reload.f_name
  end

  test 'should delete own record as driver' do
    user_count = User.count
    delete api_v1_user_path(@user), headers: @authorized_headers
    assert_equal User.count, user_count - 1
  end
end
