# frozen_string_literal: true

module Queries
  class IndexAddresses < Queries::BaseQuery
    type [Types::AddressType], null: false

    def resolve
      check_logged_in_user

      Address.all.order(created_at: :asc)
    end
  end
end
