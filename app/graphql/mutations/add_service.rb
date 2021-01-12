# frozen_string_literal: true

module Mutations
  class AddService < Mutations::BaseMutation
    argument :params, Types::Input::ServiceInputType, required: true

    field :service, Types::ServiceType, null: false

    def ready?(**_args)
      error_unless_admin
    end

    def resolve(params:)
      check_logged_in_user

      service_params = Hash(params)

      service = Service.create!(service_params)

      { service: service }
    end
  end
end
