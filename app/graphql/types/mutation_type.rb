# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :auth_user, mutation: Mutations::AuthUser

    field :create_address, mutation: Mutations::Create::CreateAddress
    field :create_base_location, mutation: Mutations::Create::CreateBaseLocation
    field :create_daily_route, mutation: Mutations::Create::CreateDailyRoute
    field :create_early_bird, mutation: Mutations::Create::CreateEarlyBird
    field :create_payment_method, mutation: Mutations::Create::CreatePaymentMethod
    field :create_plow, mutation: Mutations::Create::CreatePlow
    field :create_service, mutation: Mutations::Create::CreateService
    field :create_service_delivery, mutation: Mutations::Create::CreateServiceDelivery
    field :create_service_request, mutation: Mutations::Create::CreateServiceRequest
    field :create_size_estimate, mutation: Mutations::Create::CreateSizeEstimate
    field :create_snow_accumulation, mutation: Mutations::Create::CreateSnowAccumulation
    field :create_user, mutation: Mutations::Create::CreateUser

    field :destroy_address, mutation: Mutations::Destroy::DestroyAddress
    field :destroy_base_location, mutation: Mutations::Destroy::DestroyBaseLocation
    field :destroy_daily_route, mutation: Mutations::Destroy::DestroyDailyRoute
    field :destroy_early_bird, mutation: Mutations::Destroy::DestroyEarlyBird
    field :destroy_payment_method, mutation: Mutations::Destroy::DestroyPaymentMethod
    field :destroy_plow, mutation: Mutations::Destroy::DestroyPlow
    field :destroy_service, mutation: Mutations::Destroy::DestroyService
    field :destroy_service_request, mutation: Mutations::Destroy::DestroyServiceRequest
    field :destroy_size_estimate, mutation: Mutations::Destroy::DestroySizeEstimate
    field :destroy_snow_accumulation, mutation: Mutations::Destroy::DestroySnowAccumulation
    field :destroy_user, mutation: Mutations::Destroy::DestroyUser

    field :update_address, mutation: Mutations::Update::UpdateAddress
    field :update_base_location, mutation: Mutations::Update::UpdateBaseLocation
    field :update_daily_route, mutation: Mutations::Update::UpdateDailyRoute
    field :update_early_bird, mutation: Mutations::Update::UpdateEarlyBird
    field :update_payment_method, mutation: Mutations::Update::UpdatePaymentMethod
    field :update_plow, mutation: Mutations::Update::UpdatePlow
    field :update_service, mutation: Mutations::Update::UpdateService
    field :update_service_delivery, mutation: Mutations::Update::UpdateServiceDelivery
    field :update_service_request, mutation: Mutations::Update::UpdateServiceRequest
    field :update_size_estimate, mutation: Mutations::Update::UpdateSizeEstimate
    field :update_snow_accumulation, mutation: Mutations::Update::UpdateSnowAccumulation
    field :update_user, mutation: Mutations::Update::UpdateUser
  end
end
