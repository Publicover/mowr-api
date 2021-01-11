# frozen_string_literal: true

module Queries
  class ShowSnowAccumulation < Queries::BaseQuery
    type Types::SnowAccumulationType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      check_logged_in_user

      begin
        SnowAccumulation.find(id)
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new('Address does not exist.')
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
