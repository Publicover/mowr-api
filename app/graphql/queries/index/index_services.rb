# frozen_string_literal: true

module Queries
  module Index
    class IndexServices < Queries::BaseQuery
      type [Types::Api::ServiceType], null: false

      def resolve
        check_logged_in_user

        Service.all.order(created_at: :asc)
      end
    end
  end
end
