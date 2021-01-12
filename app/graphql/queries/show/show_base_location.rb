# frozen_string_literal: true

module Queries
  module Show
    class ShowBaseLocation < Queries::BaseQuery
      type Types::Api::BaseLocationType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        BaseLocation.find(id)
      end
    end
  end
end
