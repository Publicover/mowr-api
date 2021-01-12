# frozen_string_literal: true

class PlowrApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.unauthorized_object(_error)
    raise GraphQL::ExecutionError, Message.unauthorized
  end

  def self.unauthorized_field(_error)
    raise GraphQL::ExecutionError, Message.unauthorized
  end

  rescue_from(ActiveRecord::RecordInvalid) do |err|
    raise GraphQL::ExecutionError, "#{err}"
  end

  rescue_from(ActiveRecord::RecordNotFound) do |err|
    raise GraphQL::ExecutionError, "#{err}"
  end
end
