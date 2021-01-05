# frozen_string_literal: true

module Mutations
  class UpdateEarlyBird < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::EarlyBirdInputType, required: true

    field :early_bird, Types::EarlyBirdType, null: false

    # def ready?(**args)
    #   raise GraphQL::ExecutionError, Message.unauthorized if context[:current_user].driver?
    #   raise GraphQL::ExecutionError, Message.unauthorized unless
    #         context[:current_user].admin? || context[:current_user].addresses.pluck(:id).include?(args[:id].to_i)
    #
    #   true
    # end

    def resolve(id:, params:)
      early_bird_params = Hash(params)
      early_bird = EarlyBird.find(id)
      address = early_bird.address

      if early_bird.update(early_bird_params)
        {early_bird: early_bird, address: address}
      else
        { errors: early_bird.errors.full_messages }
      end
    end
  end
end
