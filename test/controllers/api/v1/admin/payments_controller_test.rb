require 'test_helper'

class Api::V1::Admin::PaymentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    login_as_admin
  end

  test 'should get all payments as admin' do
    get api_v1_admin_payments_path, headers: @admin_headers
    assert_response :success
    assert_equal Payment.count, json['data'].size
  end

  test 'should get single payment as admin' do
    get api_v1_admin_payment_path(payments(:one)), headers: @admin_headers
    assert_response :success
    assert_equal payments(:one).id, json['data']['id'].to_i
  end

  test 'should create payment as admin' do
    assert_difference('Payment.count') do
      post api_v1_admin_payments_path, params: { payment: {
          cost_in_cents: 15000,
          stripe_charge_id: "cus_paid",
          user_id: users(:customer).id,
          stripe_user_id: "cus_Il0otsjoN4ck5r",
          payment_method_id: payment_methods(:one).id,
          last4: "4242",
          receipt_url: "www.paid.com"
        }
      }.to_json, headers: @admin_headers
    end
  end

  test 'should update payment as admin' do
    patch api_v1_admin_payment_path(payments(:one)), params: { payment: {
        stripe_user_id: 'justSomeGuy'
      }
    }.to_json, headers: @admin_headers

    assert_response :success
    assert_equal payments(:one).reload.stripe_user_id, json['data']['attributes']['stripe_user_id']
  end

  test 'should delete payment as admin' do
    assert_difference('Payment.count', -1) do
      delete api_v1_admin_payment_path(payments(:one)), headers: @admin_headers
    end
  end
end
