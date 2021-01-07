# frozen_string_literal: true

module ServiceRequestQuery
  def index_service_requests_helper
    <<~GQL
      query {
        indexServiceRequests {
          id
          status
          serviceSubtotal
          serviceIds
          addressId

          address {
            id
            name
            line1
            line2
            city
            state
            zip
            driveway
            latitude
            longitude
          }
        }
      }
    GQL
  end

  def show_service_request_helper(id)
    <<~GQL
      query {
        showServiceRequest(id:#{id}) {
          id
          status
          serviceSubtotal
          serviceIds
          addressId

          address {
            id
            name
            line1
            line2
            city
            state
            zip
            driveway
            latitude
            longitude
          }
        }
      }
    GQL
  end
end
