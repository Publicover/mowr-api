# frozen_string_literal: true

module Mutations
  module Update
    class UpdatePlow < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::PlowInputType, required: true

      field :plow, Types::Api::PlowType, null: true

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:, params:)
        check_logged_in_user

        plow_params = Hash(params)
        plow = Plow.find(id)
        plow.update(plow_params)

        { plow: plow }
      end
    end
  end
end
