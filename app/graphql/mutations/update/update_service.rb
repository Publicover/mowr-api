# frozen_string_literal: true

module Mutations
  module Update
    class UpdateService < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::ServiceInputType, required: true

      field :service, Types::Api::ServiceType, null: false

      def ready?(**_args)
        error_unless_admin
      end

      def resolve(id:, params:)
        check_logged_in_user

        service_params = Hash(params)
        service = Service.find(id)
        service.update(service_params)

        { service: service }
      end
    end
  end
end
