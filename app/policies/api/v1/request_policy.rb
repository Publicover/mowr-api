# frozen_string_literal: true

module Api
  module V1
    class RequestPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
        end
      end

      def index?
        return true if user.admin? || user.customer?

        false
      end

      def show?
        true
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

      end
