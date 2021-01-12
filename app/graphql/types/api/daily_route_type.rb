# frozen_string_literal: true

module Types
  module Api
    class DailyRouteType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
                  context[:current_user].driver?)
      end
      field :id, ID, null: true
      field :addresses_in_order, [Integer], null: false
    end
  end
end
