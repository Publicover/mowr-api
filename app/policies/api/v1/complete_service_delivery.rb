# frozen_string_literal: true

module Api
  module V1
    class CompleteServiceDeliveryPolicy < ApplicationPolicy
      class Scope < Scope
        def resolve
          return scope.all if user.admin?
        end
      end

      def mark_complete?
        return true if user.admin? || user.driver?

        false
      end

      def permitted_attributes
        [:complete]
      end
    end
  end
end
