# frozen_string_literal: true

module ServiceRequestMutation
  def add_service_request_helper(address_id)
    <<~GQL
      mutation {
        addServiceRequest(input:{params:{
          addressId:#{address_id},
          serviceIds:#{Service.pluck(:id)}
        }}) {
          serviceRequest {
            id
            serviceIds
            status
            serviceSubtotal

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

  def update_service_request_helper(id, service_id)
    <<~GQL
      mutation {
        updateServiceRequest(input:{id:#{id}, params:{
            serviceIds:[#{service_id}]
            }}) {
              serviceRequest {
                id
                serviceIds
                status
                serviceSubtotal
                addressId

              } address {
                id
                name
                line1
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

  def destroy_service_request_helper(id)
    <<~GQL
      mutation {
        destroyServiceRequest(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
