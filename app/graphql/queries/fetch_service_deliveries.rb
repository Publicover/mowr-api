# frozen_string_literal: true

module Queries
  class FetchServiceDeliveries < Queries::BaseQuery
    type [Types::ServiceDeliveryType], null: false

    def resolve
      ServiceDelivery.all.order(created_at: :asc)
    end
  end
end
