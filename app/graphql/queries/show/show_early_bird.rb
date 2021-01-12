# frozen_string_literal: true

module Queries
  module Show
    class ShowEarlyBird < Queries::BaseQuery
      type Types::EarlyBirdType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        EarlyBird.find(id)
      end
    end
  end
end
