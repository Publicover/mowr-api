# frozen_string_literal: true

module ServiceDeliveryQuery
  def fetch_service_deliveries_helper
    <<~GQL
      query {
        fetchServiceDeliveries {
          id
          totalCost
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

  def fetch_service_delivery_helper(id)
    <<~GQL
      query {
        fetchServiceDelivery(id:#{id}) {
          id
          totalCost
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
