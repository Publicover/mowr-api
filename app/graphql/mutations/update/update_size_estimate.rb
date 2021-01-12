# frozen_string_literal: true

module Mutations
  module Update
    class UpdateSizeEstimate < Mutations::BaseMutation
      argument :id, ID, required: true
      argument :params, Types::Input::SizeEstimateInputType, required: true

      field :size_estimate, Types::SizeEstimateType, null: false
      field :address, Types::AddressType, null: true

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].size_estimates.pluck(:id).include?(args[:id].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(id:, params:)
        check_logged_in_user

        size_estimate_params = Hash(params)
        size_estimate = SizeEstimate.find(id)
        address = size_estimate.address

        { size_estimate: size_estimate, address: address }
      end
    end
  end
end
