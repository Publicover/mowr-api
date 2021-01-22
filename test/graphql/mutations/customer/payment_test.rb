require 'test_helper'

class Mutations::PaymentTest < ActionDispatch::IntegrationTest
  test 'should not create payment as customer' do
    graphql_as_customer

    post graphql_path, params: { query: create_payment_helper(users(:customer).id, payment_methods(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update payment as customer' do
    graphql_as_customer

    post graphql_path, params: { query: update_payment_helper(payments(:two).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy payment as customer' do
    graphql_as_customer

    post graphql_path, params: { query: destroy_payment_helper(payments(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
