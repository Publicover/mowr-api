# frozen_string_literal: true

module ServiceDeliveryMutation
  def add_service_delivery_helper(id)
    <<~GQL
      mutation {
        addServiceDelivery(input:{params:{
          addressId:#{id}
        }}) {
          serviceDelivery {
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
      }
    GQL
  end

  def update_service_delivery_helper(id)
    # can't actually change the total cost
    <<~GQL
      mutation {
        updateServiceDelivery(input:{id:605, params:{
          totalCost:50.0
        }}) {
          serviceDelivery {
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
      }
    GQL
  end
end
