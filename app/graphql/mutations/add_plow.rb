# frozen_string_literal: true

module Mutations
  class AddPlow < Mutations::BaseMutation
    argument :params, Types::Input::PlowInputType, required: true

    field :plow, Types::PlowType, null: false

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      check_logged_in_user

      plow_params = Hash(params)

      begin
        plow = Plow.create!(plow_params)

        { plow: plow }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
