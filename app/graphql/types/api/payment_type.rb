# frozen_string_literal: true

module Types
  module Api
    class PaymentType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
                  object.user_id == context[:current_user].id)
      end
      field :id, ID, null: true
      field :cost_in_cents, Integer, null: true
      field :stripe_charge_id, String, null: true
      field :user_id, ID, null: true
      field :stripe_user_id, String, null: true
      field :payment_method_id, String, null: true
      field :last4, String, null: true
      field :receipt_url, String, null: true
      field :payment_method, Types::Api::PaymentMethodType, null: true
    end
  end
end
