# frozen_string_literal: true

module Queries
  class ShowAddress < Queries::BaseQuery
    type Types::AddressType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      check_logged_in_user

      Address.find(id)
    end
  end
end
