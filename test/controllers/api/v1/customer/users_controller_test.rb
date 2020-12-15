require 'test_helper'

class Api::V1::Customer::UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
  end

  test 'should not get index as customer' do
    get api_v1_customer_users_path, headers: @customer_headers
    assert_match json['message'], Message.unauthorized
  end

  test 'should show own record as customer' do
    get api_v1_customer_user_path(@customer), headers: @customer_headers
    assert_response :success
  end

  test 'should update own record as customer' do
    patch api_v1_customer_user_path(@customer), params: { user: { f_name: 'New Name McGee' } }.to_json, headers: @customer_headers
    assert_response :success
    assert_equal 'New Name McGee', @customer.reload.f_name
  end

  test 'should delete own record as customer' do
    user_count = User.count
    delete api_v1_customer_user_path(@customer), headers: @customer_headers
    assert_equal User.count, user_count - 1
  end
end
