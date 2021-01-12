# frozen_string_literal: true

module Mutations
  module Update
    class UpdateServiceRequest < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::ServiceRequestInputType, required: true

      field :service_request, Types::Api::ServiceRequestType, null: false
      field :address, Types::Api::AddressType, null: true

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].service_requests.pluck(:id).include?(args[:id].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:, params:)
        check_logged_in_user

        service_request_params = Hash(params)
        service_request = ServiceRequest.find(id)
        service_request.update(service_request_params)
        address = service_request.address

        { service_request: service_request, address: address }
      end
    end
  end
end
