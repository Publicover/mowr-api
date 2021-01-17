require 'test_helper'

class Mutations::PaymentMethodTest < ActionDispatch::IntegrationTest
  test 'should create payment method for any user as admin' do
    graphql_as_admin

    assert_difference('PaymentMethod.count') do
      post graphql_path, params: { query: create_payment_method_helper(users(:three).id) }
    end
  end

  test 'should update payment method for any user as admin' do
    payment_method = payment_methods(:one)
    name = Faker::Lorem.word
    graphql_as_admin

    post graphql_path, params: { query: update_payment_method_helper(payment_method.id, name) }

    assert_response :success
    assert_equal payment_method.reload.nickname, json['data']['updatePaymentMethod']['paymentMethod']['nickname']
  end

  test 'should destroy any payment as admin' do
    graphql_as_admin

    assert_difference('PaymentMethod.count', -1) do
      post graphql_path, params: { query: destroy_payment_method_helper(payment_methods(:one).id) }
    end
  end
end
