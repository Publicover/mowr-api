# frozen_string_literal: true

module Mutations
  class UpdateSizeEstimate < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::SizeEstimateInputType, required: true

    field :size_estimate, Types::SizeEstimateType, null: false
    field :address, Types::AddressType, null: true

    def ready?(**args)
      raise GraphQL::ExecutionError, Message.unauthorized if context[:current_user].driver?
      raise GraphQL::ExecutionError, Message.unauthorized unless
            context[:current_user].admin? || context[:current_user].addresses.pluck(:id).include?(args[:id].to_i)

      true
    end

    def resolve(id:, params:)
      size_estimate_params = Hash(params)
      size_estimate = SizeEstimate.find(id)
      address = size_estimate.address

      if size_estimate.update(size_estimate_params)
        { size_estimate: size_estimate, address: address }
      else
        { errors: size_estimate.errors.full_messages}
      end
    end
  end
end
