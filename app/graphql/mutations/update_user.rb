module Mutations
  class UpdateUser < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :params, Types::Input::UserInputType, required: true

    field :user, Types::UserType, null: false

    def resolve(id:, params:)
      user_params = Hash params

      user = User.find(id)

      if user.update(user_params)
        { user: user }
      else
        { errors: user.errors.full_messages}
      end

    # rescue ActiveRecord::RecordInvalid => e
    #   GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
    #     " #{e.record.errors.full_messages.join(', ')}")
    end
  end
end
