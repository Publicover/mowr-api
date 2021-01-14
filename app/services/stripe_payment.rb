# frozen_string_literal: true

class StripePayment
  def initialize(service_delivery)
    @amount = service_delivery.total_cost_in_cents
    @service_delivery_id = service_delivery.id
    @user = service_delivery.user
    @payment_method = @user.payment_method.stripe_pm_id
    @idempotency_key = SecureRandom.uuid
    @receipt_email = @user.email
  end

  def authorize_and_charge
    @payment_intent = Stripe::PaymentIntent.create(
      amount: @amount,
      capture_method: 'automatic',
      confirmation_method: 'automatic',
      confirm: true,
      currency: 'usd',
      customer: @user.stripe_id,
      metadata: {
        service_delivery_id: @service_delivery_id,
        customer_id: @user.id
      },
      payment_method_types: ['card'],
      payment_method: @payment_method,
      receipt_email: @receipt_email
    )
  end
end
