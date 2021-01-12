# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :auth_user, mutation: Mutations::AuthUser
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :create_address, mutation: Mutations::CreateAddress
    field :update_address, mutation: Mutations::UpdateAddress
    field :create_early_bird, mutation: Mutations::CreateEarlyBird
    field :update_early_bird, mutation: Mutations::UpdateEarlyBird
    field :update_size_estimate, mutation: Mutations::UpdateSizeEstimate
    field :create_size_estimate, mutation: Mutations::CreateSizeEstimate
    field :create_service, mutation: Mutations::CreateService
    field :update_service, mutation: Mutations::UpdateService
    field :create_service_request, mutation: Mutations::CreateServiceRequest
    field :update_service_request, mutation: Mutations::UpdateServiceRequest
    field :create_service_delivery, mutation: Mutations::CreateServiceDelivery
    field :update_service_delivery, mutation: Mutations::UpdateServiceDelivery
    field :destroy_address, mutation: Mutations::DestroyAddress
    field :destroy_early_bird, mutation: Mutations::DestroyEarlyBird
    field :destroy_service_request, mutation: Mutations::DestroyServiceRequest
    field :destroy_service, mutation: Mutations::DestroyService
    field :destroy_size_estimate, mutation: Mutations::DestroySizeEstimate
    field :destroy_user, mutation: Mutations::DestroyUser
    field :create_base_location, mutation: Mutations::CreateBaseLocation
    field :update_base_location, mutation: Mutations::UpdateBaseLocation
    field :destroy_base_location, mutation: Mutations::DestroyBaseLocation
    field :create_plow, mutation: Mutations::CreatePlow
    field :update_plow, mutation: Mutations::UpdatePlow
    field :destroy_plow, mutation: Mutations::DestroyPlow
    field :create_snow_accumulation, mutation: Mutations::CreateSnowAccumulation
    field :udpate_snow_accumulation, mutation: Mutations::UpdateSnowAccumulation
    field :destroy_snow_accumulation, mutation: Mutations::DestroySnowAccumulation
    field :create_daily_route, mutation: Mutations::CreateDailyRoute
    field :update_daily_route, mutation: Mutations::UpdateDailyRoute
    field :destroy_daily_route, mutation: Mutations::DestroyDailyRoute
  end
end
