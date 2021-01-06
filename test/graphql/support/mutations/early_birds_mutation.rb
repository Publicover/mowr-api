# frozen_string_literal: true

module EarlyBirdsMutation
  def add_early_bird_helper(address_id)
    <<~GQL
      mutation {
        addEarlyBird(input:{params:{
          priority:0,
          addressId:#{address_id}
          }}) {
            earlyBird {
              priority
              address {
                id
              }
            }
          }
        }
    GQL
  end

  def update_early_bird_helper(id)
    <<~GQL
      mutation {
        updateEarlyBird(input:{id:#{id}, params:{
          priority:1
          }}) {
            earlyBird {
              id
              priority
              address {
                id
              }
            }
          }
      }
    GQL
  end
end
