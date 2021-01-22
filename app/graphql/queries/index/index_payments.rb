# frozen_string_literal: true

module Queries
  module Index
    class IndexPayments < Queries::BaseQuery
      type [Types::Api::PaymentType], null: false

      def resolve
        check_logged_in_user

        return_for_admin_or_owner(Payment)
      end
    end
  end
end
