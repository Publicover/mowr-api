# frozen_string_literal: true

require_relative '../support/addresses_query'
require_relative '../support/addresses_mutation'
require_relative '../support/auth_mutation'
require_relative '../support/early_birds_query'
require_relative '../support/everything_query'
require_relative '../support/graphql_login'
require_relative '../support/users_mutation'
require_relative '../support/users_query'

module GraphqlRequirements

  class Minitest::Test
    include AddressesQuery
    include AddressesMutation
    include AuthMutation
    include EverythingQuery
    include GraphqlLogin
    include UsersQuery
    include UsersMutation
    include EarlyBirdsQuery
  end
end
