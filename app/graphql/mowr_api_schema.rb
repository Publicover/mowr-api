# frozen_string_literal: true

class MowrApiSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
