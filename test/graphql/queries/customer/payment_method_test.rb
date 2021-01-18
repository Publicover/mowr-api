require 'test_helper'

class Queries::PaymentMethodTest < ActionDispatch::IntegrationTest
  test 'should get all payment methods as customer' do
    user_method_count = users(:customer).payment_methods.count
    graphql_as_customer

    post graphql_path, params: { query: index_payment_methods_helper }

    assert_response :success
    assert_equal user_method_count, json['data']['indexPaymentMethods'].size
    assert PaymentMethod.count > user_method_count
  end

  test 'should get own payment method as customer' do
    graphql_as_customer

    post graphql_path, params: { query: show_payment_method_helper(payment_methods(:one).id) }

    assert_response :success
    assert_equal payment_methods(:one).id, json['data']['showPaymentMethod']['id'].to_i
  end

  test 'should not get another payment method as customer' do
    graphql_as_driver

    post graphql_path, params: { query: show_payment_method_helper(payment_methods(:three).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
