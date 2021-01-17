# frozen_string_literal: true

module Types
  module Input
    class PaymentMethodInputType < Types::BaseInputObject
      argument :nickname, String, required: false
      argument :stripe_pm_id, String, required: false
      argument :stripe_user_id, String, required: false
      argument :stripe_token, String, required: false
      argument :brand, String, required: false
      argument :last4, String, required: false
      argument :exp_month, String, required: false
      argument :exp_year, String, required: false
      argument :status, Integer, required: false
      argument :user_id, ID, required: false
    end
  end
end
