# frozen_string_literal: true

module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    def check_logged_in_user
      return if context[:session][:token] && context[:current_user]

      raise(ExceptionHandler::InvalidToken, Message.invalid_token)
    end

    def get_associations(klass)
      context[:current_user].send(klass.to_s.underscore.downcase.pluralize)
    end

    def return_for_admin_or_owner(klass)
      if context[:current_user].admin?
        klass.all.order(created_at: :asc)
      elsif context[:current_user].customer?
        get_associations(klass)
      else
        raise GraphQL::ExecutionError, Message.unauthorized
      end
    end

    def return_for_admin_driver_or_owner(klass)
      if context[:current_user].admin? || context[:current_user].driver?
        klass.all.order(created_at: :asc)
      elsif context[:current_user].customer?
        get_associations(klass)
      else
        raise GraphQL::ExecutionError, Message.unauthorized
      end
    end
  end
end
