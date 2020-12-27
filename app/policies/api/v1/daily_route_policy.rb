# frozen_string_literal: true

module Api
  module V1
    class DailyRoutePolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin?
        end
      end

      def index?
        return true if user.admin?
        false
      end

      def show?
        return true if user.admin? || user.driver?
      end

      def create?
        index?
      end

      def update?
        index?
      end

      def destroy?
        index?
      end

      def permitted_attributes
        [:addresses_in_order]
      end
    end
  end
end
