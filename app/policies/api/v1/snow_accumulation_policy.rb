# frozen_string_literal: true

module Api
  module V1
    class SnowAccumulationPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin?
        end
      end

      def index?
        return true if user.admin?
      end

      def show?
        index?
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
        [:inches]
      end
    end
  end
end
