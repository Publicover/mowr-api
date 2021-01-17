# frozen_string_literal: true

# The front end is responsible for reaching out to Stripe to create this on their system.
# They should send some info back from the response to create this object AFTER
#   it has been assigned an ID by Stripe.

class PaymentMethod < ApplicationRecord
  belongs_to :user, inverse_of: :payment_methods

  validates :stripe_pm_id, :stripe_user_id, :stripe_token, :last4, :user_id, presence: true

  enum status: {
    primary: 0,
    tertiary: 1
  }
end
