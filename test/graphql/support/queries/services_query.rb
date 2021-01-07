# frozen_string_literal: true

module ServicesQuery
  def index_services_helper
    <<~GQL
      query {
        indexServices {
          id
          name
          pricePerInchOfSnow
          pricePerDriveway
        }
      }
    GQL
  end

  def show_service_helper(id)
    <<~GQL
      query {
        showService(id: #{id}) {
          id
          name
          pricePerInchOfSnow
          pricePerDriveway
        }
      }
    GQL
  end
end
