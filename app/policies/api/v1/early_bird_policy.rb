# frozen_string_literal: true

module Api
  module V1
    class EarlyBirdPolicy < ApplicationPolicy
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
        [:address_id, :priority]
      end
    end
  end
end
