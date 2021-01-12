# frozen_string_literal: true

module Queries
  module Show
    class ShowUser < Queries::BaseQuery
      type Types::UserType, null: false
      argument :id, ID, required: true

      def resolve(id:)
        check_logged_in_user

        User.find(id)
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new('User does not exist.')
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
