# frozen_string_literal: true

module EverythingQuery
  def fetch_everything_helper
    <<~GQL
      query {
        indexBaseLocations{
          id
          name
          line1
          line2
          city
          state
          zip
          latitude
          longitude
         }

         indexPlows {
           id
           licencePlate
           year
           make
           model
           userId
         }

         indexSnowAccumulations {
           inches
         }

        indexUsers {
          id
          fName
          lName
          role
          phone

          addresses {
            id
            name
            line1
            line2
            city
            state
            driveway
            latitude
            longitude

            sizeEstimate {
              id
              squareFootage
              status
              addressId
            }

            serviceRequest {
              id
              status
              serviceIds
              serviceSubtotal
              addressId
            }

            earlyBird {
              id
              priority
            }
          }
        }

        indexDailyRoutes {
          id
          addressesInOrder
        }

        indexServiceDeliveries {
          id
          addressId
          totalCost
        }

        indexServices {
          id
          name
          pricePerInchOfSnow
          pricePerDriveway
        }
      }
    GQL
  end
end
