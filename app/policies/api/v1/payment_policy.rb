# frozen_string_literal: true

module Api
  module V1
    class PaymentPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin?
          return scope.where(user_id: user.id) if user.customer?
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
        %i[
          cost_in_cents
          stripe_charge_id
          user_id
          stripe_user_id
          payment_method_id
          last4
          receipt_url
          stripe_payment_id
        ]
      end
    end
  end
end
