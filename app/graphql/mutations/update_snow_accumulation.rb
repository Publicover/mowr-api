# frozen_string_literal: true

module Mutations
  class UpdateSnowAccumulation < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::SnowAccumulationInputType, required: true

    field :snow_accumulation, Types::SnowAccumulationType, null: false

    def ready?(**_args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:, params:)
      check_logged_in_user

      snow_accumulation_params = Hash(params)
      snow_accumulation = SnowAccumulation.find(id)

      if snow_accumulation.update(snow_accumulation_params)
        { snow_accumulation: snow_accumulation }
      else
        { errors: address.errors.full_messages }
      end
    end
  end
end
