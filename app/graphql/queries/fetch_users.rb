# frozen_string_literal: true

module Queries
  class FetchUsers < Queries::BaseQuery
    type [Types::UserType], null: false

    def resolve
      User.all.order(created_at: :asc)
    end
  end
end
