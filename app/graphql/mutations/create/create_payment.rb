# frozen_string_literal: true

module Mutations
  module Create
    class CreatePayment < Mutations::BaseMutation
      argument :params, Types::Input::PaymentInputType, required: true

      field :payment, Types::Api::PaymentType, null: false

      def ready?(**_args)
        return true if context[:current_user].admin?

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(params:)
        check_logged_in_user

        payment_params = Hash(params)
        payment = Payment.create!(payment_params)

        { payment: payment }
      end
    end
  end
end
