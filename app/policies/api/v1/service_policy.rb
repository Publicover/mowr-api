# frozen_string_literal: true

module Api
  module V1
    class Api::V1::ServicePolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
        end
      end

      def index?
        true
      end

      def show?
        true
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

      def permitted_attributes
        [:name, :cost, :time_estimate]
      end
    end
  end
end
