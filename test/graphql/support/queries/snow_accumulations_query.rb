# frozen_string_literal: true

module SnowAccumulationsQuery
  def index_snow_accumulations_helper
    <<~GQL
      query {
        indexSnowAccumulations {
          inches
        }
      }
    GQL
  end

  def show_snow_accumulations_helper(id)
    <<~GQL
      query {
        showSnowAccumulation(id:#{id}) {
          id
          inches
        }
      }
    GQL
  end
end
