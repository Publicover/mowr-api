# frozen_string_literal: true

module Queries
  module Show
    class ShowService < Queries::BaseQuery
      type Types::ServiceType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        Service.find(id)
      end
    end
  end
end
