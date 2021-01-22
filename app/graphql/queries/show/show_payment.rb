# frozen_string_literal: true

module Queries
  module Show
    class ShowPayment < Queries::BaseQuery
      type Types::Api::PaymentType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        Payment.find(id)
      end
    end
  end
end
