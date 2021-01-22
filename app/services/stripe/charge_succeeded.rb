# frozen_string_literal: true

module Stripe
  class ChargeSucceeded
    # rubocop:disable Metrics/AbcSize
    def call(event)
      return unless event.data.object.status == "succeeded"

      payment_method = PaymentMethod.find_by(stripe_pm_id: event.data.object.payment_method)
      user = payment_method.user

      Payment.create(
        cost_in_cents: event.data.object.amount_captured,
        stripe_charge_id: event.data.object.id,
        user_id: user.id,
        stripe_user_id: user.stripe_id,
        last4: payment_method.last4,
        receipt_url: event.data.object.receipt_url
      )
    end
    # rubocop:enable Metrics/AbcSize
  end
end
