# frozen_string_literal: true

module Mutations
  class UpdateEarlyBird < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::EarlyBirdInputType, required: true

    field :early_bird, Types::EarlyBirdType, null: false
    field :address, Types::AddressType, null: true

    def ready?(**args)
      return true if context[:current_user].admin?
      return true if context[:current_user].early_birds.pluck(:id).include?(args[:id].to_i)

      raise GraphQL::ExecutionError, Message.unauthorized
    end

    def resolve(id:, params:)
      check_logged_in_user

      early_bird_params = Hash(params)
      early_bird = EarlyBird.find(id)
      address = early_bird.address

      if early_bird.update(early_bird_params)
        { early_bird: early_bird, address: address }
      else
        { errors: early_bird.errors.full_messages }
      end
    end
  end
end
