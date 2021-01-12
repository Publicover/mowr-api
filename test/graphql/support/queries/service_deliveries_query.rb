# frozen_string_literal: true

module ServiceDeliveriesQuery
  def index_service_deliveries_helper
    <<~GQL
      query {
        indexServiceDeliveries {
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

  def show_service_delivery_helper(id)
    <<~GQL
      query {
        showServiceDelivery(id:#{id}) {
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
