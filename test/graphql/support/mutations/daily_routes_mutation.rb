# frozen_string_literal: true

module DailyRoutesMutation
  def create_daily_route_helper
    <<~GQL
      mutation {
        createDailyRoute(input:{params:{
          addressesInOrder:[
            12, 14, 15, 22
          ]
        }}) {
          dailyRoute {
            id
            addressesInOrder
          }
        }
      }
    GQL
  end

  def auto_create_daily_route_helper
    <<~GQL
      mutation {
        createDailyRoute(input:{params:{
          calculateRoute: "true"
        }}) {
          dailyRoute {
            id
            addressesInOrder
          }
        }
      }    
    GQL
  end

  def update_daily_route_helper(id)
    <<~GQL
      mutation {
        updateDailyRoute(input:{id:#{id}, params:{
          addressesInOrder:[
            12, 121
          ]
        }}) {
          dailyRoute {
            id
            addressesInOrder
          }
        }
      }
    GQL
  end

  def destroy_daily_route_helper(id)
    <<~GQL
      mutation {
        destroyDailyRoute(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
