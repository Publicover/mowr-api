# frozen_string_literal: true

module Queries
  module Index
    class IndexUsers < Queries::BaseQuery
      type [Types::Api::UserType], null: false

      def resolve
        check_logged_in_user

        @users = User.all.order(created_at: :asc)
      end
    end
  end
end
