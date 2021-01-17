# frozen_string_literal: true

module Queries
  module Index
    class IndexPaymentMethods < Queries::BaseQuery
      type [Types::Api::PaymentMethodType], null: false

      def resolve
        check_logged_in_user

        return_for_admin_or_owner(PaymentMethod)
      end
    end
  end
end
