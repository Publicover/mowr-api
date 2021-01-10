# frozen_string_literal: true

module Queries
  class IndexPlows < Queries::BaseQuery
    type [Types::PlowType], null: false

    def resolve
      check_logged_in_user

      Plow.all.order(created_at: :asc)
    end
  end
end
