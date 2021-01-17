# frozen_string_literal: true

module Queries
  module Show
    class ShowPaymentMethod < Queries::BaseQuery
      type Types::Api::PaymentMethodType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        PaymentMethod.find(id)
      end
    end
  end
end
