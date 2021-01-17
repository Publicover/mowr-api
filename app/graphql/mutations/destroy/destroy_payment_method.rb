# frozen_string_literal: true

module Mutations
  module Destroy
    class DestroyPaymentMethod < Mutations::BaseMutation
      argument :id, ID, required: true

      field :is_deleted, String, null: false

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].payment_methods.pluck(:id).include?(args[:id].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:)
        payment_method = PaymentMethod.find(id)

        payment_method.destroy

        { is_deleted: Message.is_deleted(payment_method).to_s }
      end
    end
  end
end
