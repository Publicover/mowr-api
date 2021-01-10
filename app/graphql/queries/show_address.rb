# frozen_string_literal: true

module Queries
  class ShowAddress < Queries::BaseQuery
    type Types::AddressType, null: false
    argument :id, ID, required: true

    # rubocop:disable Metrics/AbcSize
    def resolve(id:)
      check_logged_in_user

      address = Address.find(id)
      
      return address if context[:current_user].admin? || context[:current_user].driver?
      return address if address.user_id == context[:current_user].id

      raise GraphQL::ExecutionError, Message.unauthorized
    rescue ActiveRecord::RecordNotFound => _e
      GraphQL::ExecutionError.new('Address does not exist.')
    rescue ActiveRecord::RecordInvalid => e
      GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
        " #{e.record.errors.full_messages.join(', ')}")
    end
    # rubocop:enable Metrics/AbcSize
  end
end
