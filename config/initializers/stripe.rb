# frozen_string_literal: true

ActiveSupport.on_load(:active_record) do
  Stripe.api_key = ENV['PLOWR_STRIPE_SK']
  StripeEvent.signing_secret = ENV['PLOWR_STRIPE_WEBHOOK']

  StripeEvent.configure do |events|
    events.subscribe 'charge.succeeded', Stripe::ChargeSucceeded.new
  end
end
