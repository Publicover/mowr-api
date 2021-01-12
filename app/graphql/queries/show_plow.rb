# frozen_string_literal: true

module Queries
  class ShowPlow < Queries::BaseQuery
    type Types::PlowType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      check_logged_in_user

      Plow.find(id)
    end
  end
end
