# frozen_string_literal: true

module Mutations
  class AddSizeEstimate < Mutations::BaseMutation
    argument :params, Types::Input::SizeEstimateInputType, required: true

    field :size_estimate, Types::SizeEstimateType, null: false
    field :address, Types::AddressType, null: true

    def ready?(**args)
      raise GraphQL::ExecutionError, Message.unauthorized if context[:current_user].driver?
      raise GraphQL::ExecutionError, Message.unauthorized if
            (context[:current_user].customer? && !context[:current_user].addresses.pluck(:id).include?(args[:params][:addressId].to_i))

      true
    end

    def resolve(params:)
      size_estimate_params = Hash(params)

      begin
        size_estimate = SizeEstimate.create!(size_estimate_params)
        address = size_estimate.address

        { size_estimate: size_estimate, address: address }
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
