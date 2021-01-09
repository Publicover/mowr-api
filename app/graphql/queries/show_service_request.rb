# frozen_string_literal: true

module Queries
  class ShowServiceRequest < Queries::BaseQuery
    type Types::ServiceRequestType, null: false
    argument :id, ID, required: true

    def resolve(id:)
      check_logged_in_user

      ServiceRequest.find(id)
    end
  end
end
