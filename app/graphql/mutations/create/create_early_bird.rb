# frozen_string_literal: true

module Mutations
  module Create
    class CreateEarlyBird < Mutations::BaseMutation
      argument :params, Types::Input::EarlyBirdInputType, required: true

      field :early_bird, Types::EarlyBirdType, null: false

      def ready?(**args)
        return true if context[:current_user].admin?
        return true if context[:current_user].addresses.pluck(:id).include?(args[:params][:addressId].to_i)

        raise GraphQL::ExecutionError, Message.unauthorized
      end

      def resolve(params:)
        check_logged_in_user

        early_bird_params = Hash(params)

        early_bird = EarlyBird.create!(early_bird_params)
        address = early_bird.address

        { early_bird: early_bird, address: address }
      end
    end
  end
end
