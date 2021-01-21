# frozen_string_literal: true

Stripe.api_key = ENV['PLOWR_STRIPE_SK']
StripeEvent.signing_secret = ENV['PLOWR_STRIPE_WEBHOOK']

StripeEvent.configure do |events|
  events.subscribe 'charge.succeeded', Stripe::ChargeSucceeded.new
end
