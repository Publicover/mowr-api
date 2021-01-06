# frozen_string_literal: true

module Types
  class AddressType < Types::BaseObject
    def self.authorized?(object, context)
      super && (context[:current_user].admin? ||
                context[:current_user].driver? ||
                object.user_id == context[:current_user].id)
    end
    field :id, ID, null: true
    field :line1, String, null: false
    field :line2, String, null: true
    field :city, String, null: false
    field :state, String, null: false
    field :zip, String, null: false
    field :latitude, Float, null: false
    field :longitude, Float, null: false
    field :name, String, null: false
    field :driveway, Integer, null: false
    field :user, Types::UserType, null: false
    field :early_bird, Types::EarlyBirdType, null: true
  end
end
