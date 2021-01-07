# frozen_string_literal: true

module AddressesQuery
  def index_addresses_helper
    <<~GQL
      query {
        indexAddresses {
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

  def show_address_helper(address_id)
    <<~GQL
      query {
        showAddress(id:#{address_id}) {
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
