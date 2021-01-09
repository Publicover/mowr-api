# frozen_string_literal: true

module Queries
  class ShowSizeEstimate < Queries::BaseQuery
    type Types::SizeEstimateType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      check_logged_in_user

      SizeEstimate.find(id)
    end
  end
end
