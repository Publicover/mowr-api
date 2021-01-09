# frozen_string_literal: true

module Queries
  class IndexUsers < Queries::BaseQuery
    type [Types::UserType], null: false

    def resolve
      check_logged_in_user

      @users = User.all.order(created_at: :asc)

      authorized?

      @users
    end
  end
end
