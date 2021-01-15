# frozen_string_literal: true

require "test_helper"

class StripePaymentTest < ActiveSupport::TestCase
  setup do
    populate_for_stripe_call
  end

  test 'should authorize and capture payment' do
    stripe_response = VCR.use_cassette('stripe payment service test') do
      StripePayment.new(@service_delivery).authorize_and_charge
    end
    assert_not_nil stripe_response
    assert_equal @service_delivery.id, stripe_response['metadata']['service_delivery_id'].to_i
    assert_equal @user.id, stripe_response['metadata']['customer_id'].to_i
    assert_equal @service_delivery.total_cost_in_cents, stripe_response['amount']
    assert_equal @service_delivery.total_cost_in_cents, stripe_response['amount_received']
    assert_equal @service_delivery.total_cost_in_cents, stripe_response['charges']['data'][0]['amount_captured']
    assert_equal @user.email, stripe_response['receipt_email']
    assert stripe_response['charges']['data'][0]['paid']
    assert stripe_response['status'] == 'succeeded'
    refute stripe_response['charges']['data'][0]['id'] == 'null'
    refute stripe_response['payment_method'] == 'null'
  end
end
