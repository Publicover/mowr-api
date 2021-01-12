# frozen_string_literal: true

module Mutations
  module Update
    class UpdateBaseLocation < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::BaseLocationInputType, required: true

      field :base_location, Types::BaseLocationType, null: false

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:, params:)
        check_logged_in_user

        base_location_params = Hash(params)
        base_location = BaseLocation.find(id)

        { base_location: base_location }
      end
    end
  end
end
