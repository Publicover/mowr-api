require 'test_helper'

class Api::V1::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
  end

  test 'should not get user info without auth_token' do
    get api_v1_admin_users_path, headers: @headers
    assert_match json['message'], Message.missing_token
  end

  test 'should get index as admin' do
    get api_v1_admin_users_path, headers: @admin_headers
    assert_response :success
    assert_equal User.count, json['data'].size
  end

  test 'should update user of choice as admin' do
    patch api_v1_admin_user_path(@admin),
      params: {
        target_id: User.last.id, user: { f_name: 'New Guy' }
        }.to_json,
      headers: @admin_headers
    assert_response :success
    assert_equal 'New Guy', User.last.f_name
  end

  test 'should delete user of choice as admin' do
    assert_difference('User.count', -1) do
      delete api_v1_admin_user_path(@admin), params: { target_id: User.last.id }.to_json, headers: @admin_headers
    end
  end
end
