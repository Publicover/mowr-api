# frozen_string_literal: true

module EarlyBirdsQuery
  def fetch_early_birds_helper
    <<~GQL
      query {
        fetchEarlyBirds {
          id
          priority

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

  def fetch_early_bird_helper(id)
    <<~GQL
        query {
          fetchEarlyBird(id:#{id}) {
            id
            priority
            addressId

            address {
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
end
