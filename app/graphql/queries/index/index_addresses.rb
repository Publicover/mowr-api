# frozen_string_literal: true

module Queries
  module Index
    class IndexAddresses < Queries::BaseQuery
      type [Types::Api::AddressType], null: false

      def resolve
        check_logged_in_user

        Address.all.order(created_at: :asc)
      end
    end
  end
end