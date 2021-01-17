# frozen_string_literal: true

module Queries
  module Index
    class IndexEarlyBirds < Queries::BaseQuery
      type [Types::Api::EarlyBirdType], null: false

      def resolve
        check_logged_in_user

        return_for_admin_driver_or_owner(EarlyBird)
      end
    end
  end
end
