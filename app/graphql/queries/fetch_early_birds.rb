# frozen_string_literal: true

module Queries
  class FetchEarlyBirds < Queries::BaseQuery
    type [Types::EarlyBirdType], null: false

    def resolve
      EarlyBird.all.order(created_at: :asc)
    end
  end
end
