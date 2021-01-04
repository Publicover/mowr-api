# frozen_string_literal: true

module Queries
  class FetchAddresses < Queries::BaseQuery
    type [Types::AddressType], null: false

    def resolve
      Address.all.order(created_at: :asc)
    end
  end
end
