# frozen_string_literal: true

module Mutations
  module Create
    class CreateUser < Mutations::BaseMutation
      argument :params, Types::Input::UserInputType, required: true

      field :user, Types::Api::UserType, null: false

      def resolve(params:)
        check_logged_in_user

        user_params = Hash(params)
        user = User.create!(user_params)

        { user: user }
      end
    end
  end
end
