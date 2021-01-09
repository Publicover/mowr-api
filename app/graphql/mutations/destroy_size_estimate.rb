# frozen_string_literal: true

module Mutations
  class DestroySizeEstimate < Mutations::BaseMutation
    argument :id, ID, required: true

    field :is_deleted, String, null: true

    def ready?(**args)
      return true if context[:current_user].admin?
      return true if context[:current_user].size_estimates.pluck(:id).include?(args[:id].to_i)

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:)
      check_logged_in_user

      size_estimate = SizeEstimate.find(id)

      size_estimate.destroy

      { is_deleted: Message.is_deleted(size_estimate).to_s }
    end
  end
end
