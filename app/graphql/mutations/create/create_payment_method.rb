# frozen_string_literal: true

module Mutations
  module Create
    class CreatePaymentMethod < Mutations::BaseMutation
      argument :params, Types::Input::PaymentMethodInputType, required: true

      field :payment_method, Types::Api::PaymentMethodType, null: false

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if args[:params][:userId] == context[:current_user].id.to_s

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(params:)
        check_logged_in_user

        payment_method_params = Hash(params)
        payment_method = PaymentMethod.create!(payment_method_params)

        { payment_method: payment_method }
      end
    end
  end
end
