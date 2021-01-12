# frozen_string_literal: true

module Queries
  module Show
    class ShowServiceDelivery < Queries::BaseQuery
      type Types::ServiceDeliveryType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        ServiceDelivery.find(id)
      end
    end
  end
end
