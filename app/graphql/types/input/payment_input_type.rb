# frozen_string_literal: true

module Types
  module Input
    class PaymentInputType < Types::BaseInputObject
      argument :cost_in_cents, Integer, required: false
      argument :stripe_charge_id, String, required: false
      argument :user_id, ID, required: false
      argument :stripe_user_id, String, required: false
      argument :payment_method_id, ID, required: false
      argument :last4, String, required: false
      argument :receipt_url, String, required: false
    end
  end
end
