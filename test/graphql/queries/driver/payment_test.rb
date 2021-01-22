require 'test_helper'

class Queries::PaymentTest < ActionDispatch::IntegrationTest
  test 'should not get payments as driver' do
    graphql_as_driver

    post graphql_path, params: { query: index_payments_helper }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not get payment as driver' do
    graphql_as_driver

    post graphql_path, params: { query: show_payment_helper(payments(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
