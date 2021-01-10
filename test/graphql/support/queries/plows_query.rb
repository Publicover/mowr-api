# frozen_string_literal: true

module PlowsQuery
  def index_plows_helper
    <<~GQL
      query {
        indexPlows {
          id
          licencePlate
          year
          make
          model
          userId
        }
      }
    GQL
  end

  def show_plow_helper(id)
    <<~GQL
      query {
        showPlow(id:#{id}) {
          id
          licencePlate
          year
          make
          model
          userId
        }
      }
    GQL
  end
end
