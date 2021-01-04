# frozen_string_literal: true

module EverythingQuery
  def fetch_everything_helper
    <<~GQL
      query {
        fetchUsers {
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
          }
        }
      }
    GQL
  end
end
