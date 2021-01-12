# frozen_string_literal: true

module Mutations
  class CreateUser < Mutations::BaseMutation
    argument :params, Types::Input::UserInputType, required: true

    field :user, Types::UserType, null: false

    def resolve(params:)
      check_logged_in_user

      user_params = Hash(params)
      user = User.create!(user_params)

      { user: user }
    end
  end
end
