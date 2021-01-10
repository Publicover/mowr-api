# frozen_string_literal: true

module PlowsMutation
  def add_plow_helper(user_id)
    <<~GQL
      mutation {
        addPlow(input:{params:{
          licencePlate:"3RDXsTHACHARM",
          year:"2020",
          make:"Car",
          model:"Plow",
          userId:#{user_id}
        }}) {
          plow {
            id
            licencePlate
            year
            make
            model
            userId
          }
        }
      }
    GQL
  end

  def update_plow_helper(id)
    <<~GQL
      mutation {
        updatePlow(input:{id:#{id}, params:{
          licencePlate:"NICETRY",
        }}) {
          plow {
            id
            licencePlate
            year
            make
            model
            userId
          }
        }
      }
    GQL
  end

  def destroy_plow_helper(id)
    <<~GQL
      mutation {
        destroyPlow(input:{id:#{id}}) {
          isDeleted
        }
      }
    GQL
  end
end
