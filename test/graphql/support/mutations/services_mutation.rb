# frozen_string_literal: true

module ServicesMutation
  def add_service_helper
    <<~GQL
      mutation {
        addService(input:{params:{
          name:"Test this thing",
          pricePerInchOfSnow:10,
          pricePerDriveway: [
            10, 11, 12
          ]
        }}) {
          service {
            id
            name
            pricePerInchOfSnow
            pricePerDriveway
          }
        }
      }
    GQL
  end

  def update_service_helper(id)
    <<~GQL
      mutation {
        updateService(input:{id:#{id}, params:{
          pricePerInchOfSnow:1
        }}) {
          service {
            id
            name
            pricePerInchOfSnow
            pricePerDriveway
          }
        }
      }
    GQL
  end
end
