# frozen_string_literal: true

module Mutations
  class AddEarlyBird < Mutations::BaseMutation
    argument :params, Types::Input::EarlyBirdInputType, required: true

    field :early_bird, Types::EarlyBirdType, null: false

    def ready?(**args)
      raise GraphQL::ExecutionError, Message.unauthorized if context[:current_user].driver?
      raise GraphQL::ExecutionError, Message.unauthorized if
            (context[:current_user].customer? && !context[:current_user].addresses.pluck(:id).include?(args[:params][:addressId].to_i))

      true
    end

    def resolve(params:)
      early_bird_params = Hash(params)

      begin
        early_bird = EarlyBird.create!(early_bird_params)
        address = early_bird.address

        { early_bird: early_bird, address: address }

      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
