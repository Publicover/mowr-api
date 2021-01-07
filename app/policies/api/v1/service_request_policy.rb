# frozen_string_literal: true

module Api
  module V1
    class ServiceRequestPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin? || user.driver?
          return scope.joins(:address).where(addresses: { user_id: user.id }) if user.customer?
        end
      end

      def index?
        true
      end

      def show?
        true
      end

      def create?
        return true if user.admin? || user.customer?
      end

      def update?
        create?
      end

      def destroy?
        create?
      end

      def permitted_attributes
        [:address_id, :status, :service_subtotal, service_ids: []]
      end
    end
  end
end
