# frozen_string_literal: true

module Mutations
  class UpdatePlow < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::PlowInputType, required: true

    field :plow, Types::PlowType, null: true

    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:, params:)
      check_logged_in_user

      plow_params = Hash(params)
      plow = Plow.find(id)

      if plow.update(plow_params)
        { plow: plow }
      else
        { errors: plow.errors.full_messages }
      end
    end
  end
end
