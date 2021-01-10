# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :show_user, resolver: Queries::ShowUser
    field :index_users, resolver: Queries::IndexUsers
    field :show_address, resolver: Queries::ShowAddress
    field :index_addresses, resolver: Queries::IndexAddresses
    field :show_early_bird, resolver: Queries::ShowEarlyBird
    field :index_early_birds, resolver: Queries::IndexEarlyBirds
    field :show_size_estimate, resolver: Queries::ShowSizeEstimate
    field :index_size_estimates, resolver: Queries::IndexSizeEstimates
    field :index_services, resolver: Queries::IndexServices
    field :show_service, resolver: Queries::ShowService
    field :show_service_request, resolver: Queries::ShowServiceRequest
    field :index_service_requests, resolver: Queries::IndexServiceRequests
    field :show_service_delivery, resolver: Queries::ShowServiceDelivery
    field :index_service_deliveries, resolver: Queries::IndexServiceDeliveries
    field :index_base_locations, resolver: Queries::IndexBaseLocations
    field :show_base_location, resolver: Queries::ShowBaseLocation
  end
end
