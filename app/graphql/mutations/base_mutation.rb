# frozen_string_literal: true

module Mutations
  class BaseMutation < GraphQL::Schema::RelayClassicMutation
    argument_class Types::BaseArgument
    field_class Types::BaseField
    input_object_class Types::BaseInputObject
    object_class Types::BaseObject

    def check_logged_in_user
      return if context[:session][:token] && context[:current_user]

      raise(ExceptionHandler::InvalidToken, Message.invalid_token)
    end
  end
end
