require 'test_helper'

class Api::V1::Admin::PaymentMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
  end

  test 'should get own payment methods as customer' do
    get api_v1_customer_payment_methods_path, headers: @customer_headers
    assert_response :success
    assert PaymentMethod.count > @customer.payment_methods.count
    assert_equal @customer.payment_methods.count, json['data'].size
  end

  test 'should get own payment method record as customer' do
    get api_v1_customer_payment_method_path(payment_methods(:one)), headers: @customer_headers
    assert_response :success
    assert @customer.payment_methods.pluck(:id).include?(json['data']['id'].to_i)
  end

  test 'should not get another payment method as customer' do
    get api_v1_customer_payment_method_path(payment_methods(:three)), headers: @customer_headers
    assert_equal Message.unauthorized, json['message']
  end

  test 'should create own payment method' do
    assert_difference('PaymentMethod.count') do
      post api_v1_customer_payment_methods_path, params: {
        payment_method: {
          nickname: 'Mega Platinum',
          stripe_pm_id: 'pm_card_visa',
          stripe_user_id: 'cus_Il0otsjoN4ck5r',
          stripe_token: 'tok_visa',
          brand: 'visa',
          last4: '4242',
          exp_month: '12',
          exp_year: '2050',
          status: :primary,
          user_id: @customer.id
        }
      }.to_json, headers: @customer_headers
    end
  end

  test 'should not create another payment method' do
    post api_v1_customer_payment_methods_path, params: {
      payment_method: {
        nickname: 'Mega Platinum',
        stripe_pm_id: 'pm_card_visa',
        stripe_user_id: 'cus_Il0otsjoN4ck5r',
        stripe_token: 'tok_visa',
        brand: 'visa',
        last4: '4242',
        exp_month: '12',
        exp_year: '2050',
        status: :primary,
        user_id: users(:one).id
      }
    }.to_json, headers: @customer_headers
    assert_equal Message.unauthorized, json['message']
  end

  test 'should update own payment method' do
    patch api_v1_customer_payment_method_path(payment_methods(:one)),
      params: { payment_method: { nickname: 'Broke Phi Broke' } }.to_json,
      headers: @customer_headers
    assert_response :success
    assert_equal payment_methods(:one).reload.nickname, 'Broke Phi Broke'
  end

  test 'should not update another payment method' do
    patch api_v1_customer_payment_method_path(payment_methods(:three)),
      params: { payment_method: { nickname: 'Broke Phi Broke' } }.to_json,
      headers: @customer_headers
    assert_equal Message.unauthorized, json['message']
  end
end
