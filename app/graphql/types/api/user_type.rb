# frozen_string_literal: true

module Types
  module Api
    class UserType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
                  context[:current_user].driver? ||
                  object.id == context[:current_user].id)
      end
      field :id, ID, null: false
      field :email, String, null: false
      field :f_name, String, null: false
      field :l_name, String, null: false
      field :password_digest, String, null: false
      field :role, Integer, null: false
      field :phone, String, null: false
      field :addresses, [Types::Api::AddressType], null: false
      field :size_estimates, [Types::Api::SizeEstimateType], null: true
      field :service_requests, [Types::Api::ServiceRequestType], null: true
      field :early_birds, [Types::Api::EarlyBirdType], null: true
      field :payment_methods, [Types::Api::PaymentMethodType], null: true
    end
  end
end
