# frozen_string_literal: true

module SnowAccumulationsMutation
  def add_snow_accumulation_helper
    <<~GQL
      mutation {
        addSnowAccumulation(input:{params:{
          inches:110
        }}) {
          snowAccumulation {
            id
            inches
          }
        }
      }
    GQL
  end

  def update_snow_accumulation_helper(id)
    <<~GQL
      mutation {
        udpateSnowAccumulation(input:{id:#{id}, params:{
          inches:55
        }}) {
          snowAccumulation {
            id
            inches
          }
        }
      }
    GQL
  end

  def destroy_snow_accumulation_helper(id)
    <<~GQL
      mutation {
        destroySnowAccumulation(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
