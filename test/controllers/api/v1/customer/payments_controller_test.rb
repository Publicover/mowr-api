require 'test_helper'

class Api::V1::CustomerPaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_customer
  end

  test 'should get own payments as customer' do
    get api_v1_customer_payments_path, headers: @customer_headers
    assert_response :success
    assert_equal @customer.payments.count, json['data'].size
  end

  test 'should get own payment as customer' do
    get api_v1_customer_payment_path(payments(:one)), headers: @customer_headers
    assert_response :success
    assert_equal payments(:one).id, json['data']['id'].to_i
  end
end
