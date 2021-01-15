# frozen_string_literal: true

module Api
  module V1
    class PaymentMethodPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin?
          return scope.where(user_id: user.id)
        end
      end

      def index?
        return true if user.admin? || user.customer?
      end

      def show?
        return true if user.admin?
        return true if record.user_id == user.id

        false
      end

      def create?
        show?
      end

      def update?
        show?
      end

      def destroy?
        show?
      end

      def permitted_attributes
        %i[
           nickname
           stripe_pm_id
           stripe_user_id
           stripe_token
           brand
           last4
           exp_month
           exp_year
           status
           user_id
        ]
      end
    end
  end
end
