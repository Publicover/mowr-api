# frozen_string_literal: true

module Api
  module V1
    class UserPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin?
          return scope.where(id: user.id) if user.driver? || user.customer?
        end
      end

      def index?
        return true if user.admin?
      end

      def show?
        return true if user.admin?

        user.present? && record.id == user.id
      end

      def create?
        return true if user.admin?

        false
      end

      def update?
        show?
      end

      def destroy?
        show?
      end

      def permitted_attributes
        [
          :email,
          :f_name,
          :l_name,
          :password,
          :password_confirmation,
          :role,
          service_ids: [] 
        ]
      end
    end
  end
end
