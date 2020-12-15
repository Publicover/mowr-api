require 'test_helper'

class Api::V1::Driver::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_driver
  end

  test 'should not get index as driver' do
    get api_v1_driver_users_path, headers: @driver_headers
    assert_match json['message'], Message.unauthorized
  end

  test 'should show own record as driver' do
    get api_v1_driver_user_path(@driver), headers: @driver_headers
    assert_response :success
    assert_equal json['data']['id'].to_i, @driver.id.to_i
  end

  test "should not get another user's record as driver" do
    get api_v1_driver_user_path(User.first.id), headers: @driver_headers
    assert Message.unauthorized, json['message']
  end

  test 'should update own record as driver' do
    patch api_v1_driver_user_path(@driver),
          params: { user: { f_name: 'New Name McGee' } }.to_json,
          headers: @driver_headers
    assert_response :success
    assert_equal 'New Name McGee', @driver.reload.f_name
  end

  test "should not update another user's record as driver" do
    patch api_v1_driver_user_path(User.first.id),
          params: { user: { f_name: 'New Name McGee' } }.to_json,
          headers: @driver_headers
    assert_response :success
    refute_equal 'New Name McGee', User.first.reload.f_name
    assert_equal Message.unauthorized, json['message']
  end

  test 'should delete own record as driver' do
    user_count = User.count
    delete api_v1_driver_user_path(@driver), headers: @driver_headers
    assert_equal user_count - 1, User.count
  end
end
