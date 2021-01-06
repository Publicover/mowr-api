# frozen_string_literal: true

module AddressesQuery
  def fetch_addresses_helper
    <<~GQL
      query {
        fetchAddresses {
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
    GQL
  end

  def fetch_address_helper(address_id)
    <<~GQL
      query {
        fetchAddress(id:#{address_id}) {
          id
          name
          line1
          line2
          city
          state
          driveway
          latitude
          longitude

          user {
            id
            fName
            lName
            phone
            role
          }
        }
      }
    GQL
  end
end
