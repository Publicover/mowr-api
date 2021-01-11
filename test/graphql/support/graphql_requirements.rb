# frozen_string_literal: true

require_relative '../support/mutations/addresses_mutation'
require_relative '../support/mutations/auth_mutation'
require_relative '../support/mutations/base_locations_mutation'
require_relative '../support/mutations/daily_routes_mutation'
require_relative '../support/mutations/early_birds_mutation'
require_relative '../support/mutations/graphql_login'
require_relative '../support/mutations/plows_mutation'
require_relative '../support/mutations/service_request_mutation'
require_relative '../support/mutations/service_delivery_mutation'
require_relative '../support/mutations/services_mutation'
require_relative '../support/mutations/size_estimates_mutation'
require_relative '../support/mutations/snow_accumulations_mutation'
require_relative '../support/mutations/users_mutation'
require_relative '../support/queries/addresses_query'
require_relative '../support/queries/base_locations_query'
require_relative '../support/queries/daily_routes_query'
require_relative '../support/queries/early_birds_query'
require_relative '../support/queries/everything_query'
require_relative '../support/queries/plows_query'
require_relative '../support/queries/service_delivery_query'
require_relative '../support/queries/service_request_query'
require_relative '../support/queries/services_query'
require_relative '../support/queries/size_estimates_query'
require_relative '../support/queries/snow_accumulations_query'
require_relative '../support/queries/users_query'

module GraphqlRequirements

  class Minitest::Test
    include AddressesQuery
    include AddressesMutation
    include AuthMutation
    include EverythingQuery
    include GraphqlLogin
    include SizeEstimatesMutation
    include UsersQuery
    include UsersMutation
    include EarlyBirdsQuery
    include EarlyBirdsMutation
    include SizeEstimatesQuery
    include ServicesQuery
    include ServicesMutation
    include ServiceRequestQuery
    include ServiceRequestMutation
    include ServiceDeliveryQuery
    include ServiceDeliveryMutation
    include BaseLocationsQuery
    include BaseLocationsMutation
    include PlowsQuery
    include PlowsMutation
    include SnowAccumulationsQuery
    include SnowAccumulationsMutation
    include DailyRoutesQuery
    include DailyRoutesMutation
  end
end
