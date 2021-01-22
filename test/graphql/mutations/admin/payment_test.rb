require 'test_helper'

class Mutations::PaymentTest < ActionDispatch::IntegrationTest
  test 'should create payment as admin' do
    graphql_as_admin

    assert_difference('Payment.count') do
      post graphql_path, params: { query: create_payment_helper(users(:customer).id, payment_methods(:one).id) }
    end
  end

  test 'should update payment as admin' do
    graphql_as_admin

    post graphql_path, params: { query: update_payment_helper(payments(:two).id) }

    assert_response :success
    assert_equal payments(:two).reload.cost_in_cents, json['data']['updatePayment']['payment']['costInCents']
  end

  test 'should destroy payment as admin' do
    graphql_as_admin
    assert_difference('Payment.count', -1) do
      post graphql_path, params: { query: destroy_payment_helper(payments(:one).id) }
    end
  end
end
