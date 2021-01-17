# frozen_string_literal: true

module Queries
  module Index
    class IndexAddresses < Queries::BaseQuery
      type [Types::Api::AddressType], null: false

      def resolve
        check_logged_in_user

        return_for_admin_driver_or_owner(Address)
      end
    end
  end
end
