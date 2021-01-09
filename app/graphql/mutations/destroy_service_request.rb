# frozen_string_literal: true

module Mutations
  class DestroyServiceRequest < Mutations::BaseMutation
    argument :id, ID, required: true

    field :is_deleted, String, null: true

    def ready?(**args)
      return true if context[:current_user].admin?
      return true if context[:current_user].service_requests.pluck(:id).include?(args[:id].to_i)

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:)
      check_logged_in_user

      service_request = ServiceRequest.find(id)

      service_request.destroy

      { is_deleted: Message.is_deleted(service_request).to_s }
    end
  end
end
