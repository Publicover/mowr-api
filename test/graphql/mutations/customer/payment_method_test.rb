require 'test_helper'

class Mutations::PaymentMethodTest < ActionDispatch::IntegrationTest
  test 'should create own payment method as customer' do
    graphql_as_customer

    assert_difference('PaymentMethod.count') do
      post graphql_path, params: { query: create_payment_method_helper(users(:three).id) }
    end
  end

  test 'should not create another payment method as customer' do
    graphql_as_customer

    post graphql_path, params: { query: create_payment_method_helper(users(:one).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should update own payment method as customer' do
    payment_method = payment_methods(:one)
    name = Faker::Lorem.word
    graphql_as_customer

    post graphql_path, params: { query: update_payment_method_helper(payment_method.id, name) }

    assert_response :success
    assert_equal payment_method.reload.nickname, json['data']['updatePaymentMethod']['paymentMethod']['nickname']
  end

  test 'should not update another payment method as customer' do
    payment_method = payment_methods(:three)
    name = Faker::Lorem.word
    graphql_as_customer

    post graphql_path, params: { query: update_payment_method_helper(payment_method.id, name) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end

  test 'should destroy own payment method as customer' do
    graphql_as_customer

    assert_difference('PaymentMethod.count', -1) do
      post graphql_path, params: { query: destroy_payment_method_helper(payment_methods(:one).id) }
    end
  end

  test 'should destroy another payment as customer' do
    graphql_as_customer

    post graphql_path, params: { query: destroy_payment_method_helper(payment_methods(:three).id) }

    assert_response :success
    assert_equal Message.unauthorized, json['errors'][0]['message']
  end
end
