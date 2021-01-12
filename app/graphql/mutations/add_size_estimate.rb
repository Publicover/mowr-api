# frozen_string_literal: true

module Mutations
  class AddSizeEstimate < Mutations::BaseMutation
    argument :params, Types::Input::SizeEstimateInputType, required: true

    field :size_estimate, Types::SizeEstimateType, null: false
    field :address, Types::AddressType, null: true

    def ready?(**args)
      return true if context[:current_user].admin?
      return true if context[:current_user].addresses.pluck(:id)
                                           .include?(args[:params][:addressId].to_i)

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(params:)
      check_logged_in_user

      size_estimate_params = Hash(params)
      size_estimate = SizeEstimate.create!(size_estimate_params)
      address = size_estimate.address

      { size_estimate: size_estimate, address: address }
    end
  end
end
