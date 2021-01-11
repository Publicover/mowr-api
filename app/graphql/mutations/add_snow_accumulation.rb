# frozen_string_literal: true

module Mutations
  class AddSnowAccumulation < Mutations::BaseMutation
    argument :params, Types::Input::SnowAccumulationInputType, required: true

    field :snow_accumulation, Types::SnowAccumulationType, null: false

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      check_logged_in_user

      snow_accumulation_params = Hash(params)

      begin
        snow_accumulation = SnowAccumulation.create!(snow_accumulation_params)

        { snow_accumulation: snow_accumulation }

      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
