# frozen_string_literal: true

module Mutations
  module Update
    class UpdateSnowAccumulation < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::SnowAccumulationInputType, required: true

      field :snow_accumulation, Types::Api::SnowAccumulationType, null: false

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:, params:)
        check_logged_in_user

        snow_accumulation_params = Hash(params)
        snow_accumulation = SnowAccumulation.find(id)
        snow_accumulation.update(snow_accumulation_params)

        { snow_accumulation: snow_accumulation }
      end
    end
  end
end
