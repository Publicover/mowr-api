# frozen_string_literal: true

module Mutations
  class AddServiceDelivery < Mutations::BaseMutation
    argument :params, Types::Input::ServiceDeliveryInputType, required: true

    field :service_delivery, Types::ServiceDeliveryType, null: false

    def ready?(**_args)
      error_unless_admin
    end

    def resolve(params:)
      check_logged_in_user

      service_delivery_params = Hash(params)
      service_delivery = ServiceDelivery.create!(service_delivery_params)
      address = service_delivery.address

      { service_delivery: service_delivery, address: address }
    end
  end
end