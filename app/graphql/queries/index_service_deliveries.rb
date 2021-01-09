# frozen_string_literal: true

module Queries
  class IndexServiceDeliveries < Queries::BaseQuery
    type [Types::ServiceDeliveryType], null: false

    def resolve
      check_logged_in_user

      ServiceDelivery.all.order(created_at: :asc)
    end
  end
end
