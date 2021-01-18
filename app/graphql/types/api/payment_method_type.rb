# frozen_string_literal: true

module Types
  module Api
    class PaymentMethodType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
          context[:current_user].customer? ||
          object.user_id == context[:current_user].id)
      end
      field :id, ID, null: false
      field :nickname, String, null: true
      field :stripe_pm_id, String, null: false
      field :stripe_user_id, String, null: false
      field :stripe_token, String, null: false
      field :brand, String, null: true
      field :last4, String, null: true
      field :exp_month, String, null: true
      field :exp_year, String, null: true
      field :status, Integer, null: false
      field :user_id, ID, null: false
      field :user, Types::Api::UserType, null: true
      field :calculate_route, String, null: true
    end
  end
end
