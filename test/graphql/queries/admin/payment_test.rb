require 'test_helper'

class Queries::PaymentTest < ActionDispatch::IntegrationTest
  test 'should get all payments as admin' do
    graphql_as_admin

    post graphql_path, params: { query: index_payments_helper }

    assert_response :success
    assert_equal Payment.count, json['data']['indexPayments'].size
  end

  test 'should get single payment as admin' do
    graphql_as_admin

    post graphql_path, params: { query: show_payment_helper(payments(:one).id) }

    assert_response :success
    assert_equal payments(:one).id, json['data']['showPayment']['id'].to_i
  end
end
