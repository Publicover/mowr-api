# frozen_string_literal: true

module EarlyBirdsQuery
  def index_early_birds_helper
    <<~GQL
      query {
        indexEarlyBirds {
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

  def show_early_bird_helper(id)
    <<~GQL
        query {
          showEarlyBird(id:#{id}) {
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
