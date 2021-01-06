# frozen_string_literal: true

module ServicesQuery
  def fetch_services_helper
    <<~GQL
      query {
        fetchServices {
          id
          name
          pricePerInchOfSnow
          pricePerDriveway
        }
      }
    GQL
  end

  def fetch_service_helper(id)
    <<~GQL
      query {
        fetchService(id: #{id}) {
          id
          name
          pricePerInchOfSnow
          pricePerDriveway
        }
      }
    GQL
  end
end
