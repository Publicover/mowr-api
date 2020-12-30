module Types
  module Input
    class UserInputType < Types::BaseInputObject
      argument :email, String, required: false
      argument :f_name, String, required: false
      argument :l_name, String, required: false
      argument :password, String, required: false
      argument :role, Int, required: false
      argument :phone, String, required: false
      argument :id, ID, required: false
    end
  end
end
