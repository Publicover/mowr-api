require 'test_helper'

class Queries::PaymentMethodTest < ActionDispatch::IntegrationTest
  test 'should get all payment methods as admin' do
    graphql_as_admin

    post graphql_path, params: { query: index_payment_methods_helper }

    assert_response :success
    assert_equal PaymentMethod.count, json['data']['indexPaymentMethods'].size
  end

  test 'should get single payment method as admin' do
    graphql_as_admin

    post graphql_path, params: { query: show_payment_method_helper(payment_methods(:one).id) }

    assert_response :success
    assert_equal payment_methods(:one).id, json['data']['showPaymentMethod']['id'].to_i
  end
end
