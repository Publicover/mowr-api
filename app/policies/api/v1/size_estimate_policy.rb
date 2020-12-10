# frozen_string_literal: true

module Api
  module V1
    class SizeEstimatePolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
        end
      end

      def index?
        return true if user.admin?

        false
      end

      def show?
        true
      end

      def create?
        return true if user.admin? || user.customer?

        false
      end

      def update?
        create?
      end

      def destroy?
        create?
      end

      def permitted_attributes
        %i[acreage address_id]
      end
    end
  end
end
