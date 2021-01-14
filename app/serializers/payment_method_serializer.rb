# frozen_string_literal: true

class PaymentMethodSerializer
  include FastJsonapi::ObjectSerializer
  attributes :nickname,
             :stripe_pm_id,
             :stripe_user_id,
             :stripe_token,
             :brand,
             :exp_month,
             :exp_year,
             :status,
             :user_id
  belongs_to :user
end
