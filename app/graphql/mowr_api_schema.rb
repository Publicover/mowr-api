# frozen_string_literal: true

class MowrApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  def self.unauthorized_object(_error)
    raise GraphQL::ExecutionError, Message.unauthorized
  end

  def self.unauthorized_field(_error)
    raise GraphQL::ExecutionError, Message.unauthorized
  end
end
