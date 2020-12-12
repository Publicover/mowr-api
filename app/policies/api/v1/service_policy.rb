# frozen_string_literal: true

module Api
  module V1
    class ServicePolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          scope.all
        end
      end

      def index?
        true
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

      def permitted_attributes
        %i[name price_per_quarter_hour]
      end
    end
  end
end
