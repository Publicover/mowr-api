# frozen_string_literal: true

module Api
  module V1
    class ServiceDeliveryPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
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
        [:total_cost, :address_id]
      end
    end
  end
end
