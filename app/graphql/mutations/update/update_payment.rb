# frozen_string_literal: true

module Mutations
  module Update
    class UpdatePayment < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::PaymentInputType, required: true

      field :payment, Types::Api::PaymentType, null: true

      def ready?(**args)
        return true if context[:current_user].admin?

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:, params:)
        check_logged_in_user

        payment_params = Hash(params)
        payment = Payment.find(id)
        payment.update(payment_params)

        { payment: payment }
      end
    end
  end
end
