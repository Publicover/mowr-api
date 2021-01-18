require 'test_helper'

class Mutations::PaymentMethodTest < ActionDispatch::IntegrationTest
  test 'should not create payment method as driver' do
    graphql_as_driver

    post graphql_path, params: { query: create_payment_method_helper(users(:customer).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should not update payment method as admin' do
    payment_method = payment_methods(:one)
    name = Faker::Lorem.word
    graphql_as_driver

    post graphql_path, params: { query: update_payment_method_helper(payment_method.id, name) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy any payment as driver' do
    graphql_as_driver

    post graphql_path, params: { query: destroy_payment_method_helper(payment_methods(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
