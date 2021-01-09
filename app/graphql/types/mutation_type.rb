# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :auth_user, mutation: Mutations::AuthUser
    field :add_user, mutation: Mutations::AddUser
    field :update_user, mutation: Mutations::UpdateUser
    field :add_address, mutation: Mutations::AddAddress
    field :update_address, mutation: Mutations::UpdateAddress
    field :add_early_bird, mutation: Mutations::AddEarlyBird
    field :update_early_bird, mutation: Mutations::UpdateEarlyBird
    field :update_size_estimate, mutation: Mutations::UpdateSizeEstimate
    field :add_size_estimate, mutation: Mutations::AddSizeEstimate
    field :add_service, mutation: Mutations::AddService
    field :update_service, mutation: Mutations::UpdateService
    field :add_service_request, mutation: Mutations::AddServiceRequest
    field :update_service_request, mutation: Mutations::UpdateServiceRequest
    field :add_service_delivery, mutation: Mutations::AddServiceDelivery
    field :update_service_delivery, mutation: Mutations::UpdateServiceDelivery
    field :destroy_address, mutation: Mutations::DestroyAddress
    field :destroy_early_bird, mutation: Mutations::DestroyEarlyBird
    field :destroy_service_request, mutation: Mutations::DestroyServiceRequest
    field :destroy_service, mutation: Mutations::DestroyService
    field :destroy_size_estimate, mutation: Mutations::DestroySizeEstimate
    field :destroy_user, mutation: Mutations::DestroyUser
  end
end
