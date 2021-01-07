# frozen_string_literal: true

module ServiceRequestQuery
  def fetch_service_requests_helper
    <<~GQL
      query {
        fetchServiceRequests {
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

  def fetch_service_request_helper(id)
    <<~GQL
      query {
        fetchServiceRequest(id:#{id}) {
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
