# frozen_string_literal: true

module Queries
  class FetchAddress < Queries::BaseQuery
    type Types::AddressType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      unless context[:session][:token] && context[:current_user]
        raise(ExceptionHandler::InvalidToken, Message.invalid_token)
      end

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
  end
end