# frozen_string_literal: true

module Mutations
  class CreatePlow < Mutations::BaseMutation
    argument :params, Types::Input::PlowInputType, required: true

    field :plow, Types::PlowType, null: false

    def ready?(**_args)
      error_unless_admin
    end

    def resolve(params:)
      check_logged_in_user

      plow_params = Hash(params)
      plow = Plow.create!(plow_params)

      { plow: plow }
    end
  end
end
