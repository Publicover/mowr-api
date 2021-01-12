# frozen_string_literal: true

module Queries
  module Index
    class IndexSnowAccumulations < Queries::BaseQuery
      type [Types::SnowAccumulationType], null: false

      def resolve
        check_logged_in_user

        SnowAccumulation.all.order(created_at: :asc)
      end
    end
  end
end
