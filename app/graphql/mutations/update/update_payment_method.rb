# frozen_string_literal: true

module Mutations
  module Update
    class UpdatePaymentMethod < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::PaymentMethodInputType, required: true

      field :payment_method, Types::Api::PaymentMethodType, null: false

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].payment_methods.pluck(:id).include?(args[:id].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:, params:)
        check_logged_in_user

        payment_method_params = Hash(params)
        payment_method = PaymentMethod.find(id)
        payment_method.update(payment_method_params)

        { payment_method: payment_method}
      end
    end
  end
end
