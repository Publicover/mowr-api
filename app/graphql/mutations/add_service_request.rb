# frozen_string_literal: true

module Mutations
  class AddServiceRequest < Mutations::BaseMutation
    argument :params, Types::Input::ServiceRequestInputType, required: true

    field :service_request, Types::ServiceRequestType, null: false

    def ready?(**args)
      # binding.pry
      # puts "context[:current_user].driver? #{context[:current_user].driver?}"
      # puts "context[:current_user].customer? #{context[:current_user].customer?}"
      # puts "(context[:current_user].customer? && !context[:current_user].addresses.pluck(:id).include?(args[:params][:addressId].to_i)) #{(context[:current_user].customer? && !context[:current_user].addresses.pluck(:id).include?(args[:params][:addressId].to_i))}"
      raise GraphQL::ExecutionError, Message.unauthorized if context[:current_user].driver?
      raise GraphQL::ExecutionError, Message.unauthorized if
            (context[:current_user].customer? && !context[:current_user].addresses.pluck(:id).include?(args[:params][:addressId].to_i))

      true
    end

    def resolve(params:)
      service_requst_params = Hash(params)

      begin
        service_request = ServiceRequest.create!(service_requst_params)
        address = service_request.address

        { service_request: service_request, address: address }

      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
