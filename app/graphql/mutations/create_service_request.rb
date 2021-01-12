# frozen_string_literal: true

module Mutations
  class CreateServiceRequest < Mutations::BaseMutation
    argument :params, Types::Input::ServiceRequestInputType, required: true

    field :service_request, Types::ServiceRequestType, null: false

    def ready?(**args)
      return true if context[:current_user].admin?
      return true if context[:current_user].addresses.pluck(:id)
                                           .include?(args[:params][:addressId].to_i)

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      check_logged_in_user

      service_requst_params = Hash(params)

      service_request = ServiceRequest.create!(service_requst_params)
      address = service_request.address

      { service_request: service_request, address: address }
    end
  end
end
