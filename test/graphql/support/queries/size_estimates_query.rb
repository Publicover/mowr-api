# frozen_string_literal: true

module SizeEstimatesQuery
  def fetch_size_estimates_helper
    <<~GQL
      query {
        fetchSizeEstimates {
          id
          squareFootage
          status
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

  def fetch_size_estimate_helper(id)
    <<~GQL
      query {
        fetchSizeEstimate(id:#{id}) {
          id
          squareFootage
          status
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
