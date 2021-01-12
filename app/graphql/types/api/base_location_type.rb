# frozen_string_literal: true

module Types
  module Api
    class BaseLocationType < Types::BaseObject
      def self.authorized?(object, context)
        super && (context[:current_user].admin? ||
                  context[:current_user].driver?)
      end
      field :id, ID, null: true
      field :name, String, null: false
      field :line1, String, null: false
      field :line2, String, null: true
      field :city, String, null: false
      field :state, String, null: false
      field :zip, String, null: false
      field :latitude, Float, null: false
      field :longitude, Float, null: false
    end
  end
end
