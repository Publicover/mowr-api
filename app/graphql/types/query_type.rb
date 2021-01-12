# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :index_addresses, resolver: Queries::Index::IndexAddresses
    field :index_base_locations, resolver: Queries::Index::IndexBaseLocations
    field :index_daily_routes, resolver: Queries::Index::IndexDailyRoutes
    field :index_early_birds, resolver: Queries::Index::IndexEarlyBirds
    field :index_plows, resolver: Queries::Index::IndexPlows
    field :index_services, resolver: Queries::Index::IndexServices
    field :index_service_deliveries, resolver: Queries::Index::IndexServiceDeliveries
    field :index_service_requests, resolver: Queries::Index::IndexServiceRequests
    field :index_size_estimates, resolver: Queries::Index::IndexSizeEstimates
    field :index_snow_accumulations, resolver: Queries::Index::IndexSnowAccumulations
    field :index_users, resolver: Queries::Index::IndexUsers

    field :show_address, resolver: Queries::Show::ShowAddress
    field :show_base_location, resolver: Queries::Show::ShowBaseLocation
    field :show_daily_route, resolver: Queries::Show::ShowDailyRoute
    field :show_early_bird, resolver: Queries::Show::ShowEarlyBird
    field :show_plow, resolver: Queries::Show::ShowPlow
    field :show_service, resolver: Queries::Show::ShowService
    field :show_service_delivery, resolver: Queries::Show::ShowServiceDelivery
    field :show_service_request, resolver: Queries::Show::ShowServiceRequest
    field :show_size_estimate, resolver: Queries::Show::ShowSizeEstimate
    field :show_snow_accumulation, resolver: Queries::Show::ShowSnowAccumulation
    field :show_user, resolver: Queries::Show::ShowUser
  end
end
