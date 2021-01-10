# frozen_string_literal: true

module BaseLocationsQuery
  def index_base_locations_helper
    <<~GQL
      query {
        indexBaseLocations {
          id
          name
          line1
          line2
          city
          state
          latitude
          longitude
        }
      }
    GQL
  end

  def show_base_location_helper(id)
    <<~GQL
      query {
        showBaseLocation(id:#{id}) {
          id
          name
          line1
          line2
          city
          state
          latitude
          longitude
        }
      }
    GQL
  end
end
