# frozen_string_literal: true

module Api
  module V1
    class PlowPolicy < ApplicationPolicy
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
        %i[
          licence_plate year make model color user_id
        ]
      end
    end
  end
end
