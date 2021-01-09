# frozen_string_literal: true

module Api
  module V1
    class BaseLocationPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin? || user.driver?
        end
      end

      def index?
        return true if user.admin? || user.driver?
      end

      def show?
        index?
      end

      def create?
        return true if user.admin?

        false
      end

      def update?
        create?
      end

      def destroy?
        create?
      end
    end
  end
end
