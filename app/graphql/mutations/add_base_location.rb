# frozen_string_literal: true

module Mutations
  class AddBaseLocation < Mutations::BaseMutation
    argument :params, Types::Input::BaseLocationInputType, required: true

    field :base_location, Types::BaseLocationType, null: false

    def ready?(**_args)
      error_unless_admin
    end

    def resolve(params:)
      check_logged_in_user

      base_location_params = Hash(params)
      base_location = BaseLocation.create!(base_location_params)

      { base_location: base_location }
    end
  end
end
