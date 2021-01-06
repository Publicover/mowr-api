# frozen_string_literal: true

require_relative '../support/mutations/addresses_mutation'
require_relative '../support/mutations/auth_mutation'
require_relative '../support/mutations/early_birds_mutation'
require_relative '../support/mutations/graphql_login'
require_relative '../support/mutations/users_mutation'
require_relative '../support/queries/addresses_query'
require_relative '../support/queries/early_birds_query'
require_relative '../support/queries/everything_query'
require_relative '../support/queries/size_estimates_query'
require_relative '../support/queries/users_query'

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
    include EarlyBirdsMutation
    include SizeEstimatesQuery
  end
end
