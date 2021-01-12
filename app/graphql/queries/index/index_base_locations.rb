# frozen_string_literal: true

module Queries
  module Index
    class IndexBaseLocations < Queries::BaseQuery
      type [Types::BaseLocationType], null: false

      def resolve
        check_logged_in_user

        BaseLocation.all.order(created_at: :desc)
      end
    end
  end
end
