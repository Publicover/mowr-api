require 'test_helper'

class Queries::PaymentMethodTest < ActionDispatch::IntegrationTest
  test 'should not get payment methods as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_payment_methods_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get single payment method as driver' do
    graphql_as_driver

    post graphql_path, params: { query: show_payment_method_helper(payment_methods(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
