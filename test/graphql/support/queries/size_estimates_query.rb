# frozen_string_literal: true

module SizeEstimatesQuery
  def index_size_estimates_helper
    <<~GQL
      query {
        indexSizeEstimates {
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

  def show_size_estimate_helper(id)
    <<~GQL
      query {
        showSizeEstimate(id:#{id}) {
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
