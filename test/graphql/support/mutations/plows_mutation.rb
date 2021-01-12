# frozen_string_literal: true

module PlowsMutation
  def create_plow_helper(user_id)
    <<~GQL
      mutation {
        createPlow(input:{params:{
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

  def update_plow_helper(id, plate)
    <<~GQL
      mutation {
        updatePlow(input:{id:#{id}, params:{
          licencePlate:"#{plate}",
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

  def failure_to_create_helper(user_id)
    <<~GQL
      mutation {
        createPlow(input:{params:{
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

  def failure_to_update_helper(id)
    <<~GQL
      mutation {
        updatePlow(input:{id:#{id}, params:{
          name: "FAIL"
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

  def failure_to_destroy_helper
    <<~GQL
      mutation {
        destroyPlow(input:{id:60000}) {
          isDeleted
        }
      }
    GQL
  end
end
