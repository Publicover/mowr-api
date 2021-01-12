# frozen_string_literal: true

module Queries
  class ShowSnowAccumulation < Queries::BaseQuery
    type Types::SnowAccumulationType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      check_logged_in_user

      SnowAccumulation.find(id)
    end
  end
end
