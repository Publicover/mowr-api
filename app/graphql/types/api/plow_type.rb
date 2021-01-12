# frozen_string_literal: true

module Types
  module Api
    class PlowType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
                  context[:current_user].driver?)
      end
      field :id, ID, null: true
      field :licence_plate, String, null: true
      field :year, String, null: true
      field :color, String, null: true
      field :make, String, null: true
      field :model, String, null: true
      field :user_id, Integer, null: true
    end
  end
end
