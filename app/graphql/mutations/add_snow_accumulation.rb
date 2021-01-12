# frozen_string_literal: true

module Mutations
  class AddSnowAccumulation < Mutations::BaseMutation
    argument :params, Types::Input::SnowAccumulationInputType, required: true

    field :snow_accumulation, Types::SnowAccumulationType, null: false

    def ready?(**_args)
      error_unless_admin
    end

    def resolve(params:)
      check_logged_in_user

      snow_accumulation_params = Hash(params)
      snow_accumulation = SnowAccumulation.create!(snow_accumulation_params)

      { snow_accumulation: snow_accumulation }
    end
  end
end
