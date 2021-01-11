# frozen_string_literal: true

module Mutations
  class AddBaseLocation < Mutations::BaseMutation
    argument :params, Types::Input::BaseLocationInputType, required: true

    field :base_location, Types::BaseLocationType, null: false

    def ready?(**_args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      check_logged_in_user

      base_location_params = Hash(params)

      begin
        base_location = BaseLocation.create!(base_location_params)

        { base_location: base_location }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
