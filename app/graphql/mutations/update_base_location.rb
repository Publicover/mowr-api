# frozen_string_literal: true

module Mutations
  class UpdateBaseLocation < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::BaseLocationInputType, required: true

    field :base_location, Types::BaseLocationType, null: false

    def ready?(**_args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:, params:)
      check_logged_in_user

      base_location_params = Hash(params)
      base_location = BaseLocation.find(id)

      if base_location.update(base_location_params)
        { base_location: base_location }
      else
        { errors: base_location.errors.full_messages }
      end
    end
  end
end
