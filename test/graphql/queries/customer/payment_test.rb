require 'test_helper'

class Queries::PaymentTest < ActionDispatch::IntegrationTest
  test 'should get own payments as customer' do
    graphql_as_customer

    post graphql_path, params: { query: index_payments_helper }

    assert_response :success
    assert_equal users(:customer).payments.count, json['data']['indexPayments'].size
    refute_equal Payment.count, json['data']['indexPayments'].size
  end

  test 'should get own payment as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_payment_helper(payments(:one).id) }

    assert_response :success
    assert_equal payments(:one).id, json['data']['showPayment']['id'].to_i
  end
end
