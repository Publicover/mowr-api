# frozen_string_literal: true

class PaymentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :cost_in_cents,
             :stripe_charge_id,
             :user_id,
             :stripe_user_id,
             :payment_method_id,
             :last4,
             :receipt_url

  belongs_to :user
end
