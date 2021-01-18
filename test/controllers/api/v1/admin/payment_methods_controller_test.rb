require 'test_helper'

class Api::V1::Admin::PaymentMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
  end

  test 'should get all payment methods as admin' do
    get api_v1_admin_payment_methods_path, headers: @admin_headers
    assert_response :success
    assert_equal PaymentMethod.count, json['data'].size
  end

  test 'should see any payment method as admin' do
    get api_v1_admin_payment_method_path(payment_methods(:two)), headers: @admin_headers
    assert_response :success
    assert_equal payment_methods(:two).id, json['data']['id'].to_i
  end

  test 'should create payment method for any user as admin' do
    assert_difference('PaymentMethod.count') do
      post api_v1_admin_payment_methods_path, params: { payment_method: {
        nickname: "Dana's new card", stripe_pm_id: 'returned from front end',
        stripe_user_id: 'returned from front end', stripe_token: 'returned from front end',
        brand: 'visa', last4: '5309', exp_month: '12', exp_year: '2075', status: :primary,
        user_id: users(:customer).id
      } }.to_json, headers: @admin_headers
    end
  end

  test 'should update any payment method as admin' do
    patch api_v1_admin_payment_method_path(payment_methods(:one)), params: {
      payment_method: { nickname: 'test nickname' }
    }.to_json, headers: @admin_headers
    assert_response :success
    assert_equal payment_methods(:one).reload.nickname, 'test nickname'
  end

  test 'should destroy payment method as admin' do
    assert_difference('PaymentMethod.count', -1) do
      delete api_v1_admin_payment_method_path(payment_methods(:one)),
        headers: @admin_headers
    end
  end
end
