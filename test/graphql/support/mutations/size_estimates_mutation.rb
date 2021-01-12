# frozen_string_literal: true

module SizeEstimatesMutation
  def create_size_estimate_helper(address_id)
    <<~GQL
      mutation {
        createSizeEstimate(input:{params:{
          addressId:#{address_id},
          squareFootage:300
        }}) {
          sizeEstimate {
            id
            squareFootage
            status
            addressId

          } address {
            id
            line1
            city
            state
            zip
            name
          }
        }
      }
    GQL
  end

  def update_size_estimate_helper(id)
    <<~GQL
      mutation {
        updateSizeEstimate(input:{id:#{id}, params:{
          squareFootage:300
        }}) {
          sizeEstimate {
            id
            squareFootage
            status
            addressId

          } address {
            id
            line1
            city
            state
            zip
            name
          }
        }
      }
    GQL
  end

  def destroy_size_estimate_helper(id)
    <<~GQL
      mutation {
        destroySizeEstimate(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
