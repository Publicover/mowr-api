module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :f_name, String, null: false
    field :l_name, String, null: false
    field :password_digest, String, null: false
    field :role, Integer, null: false
    field :phone, String, null: false
  end
end
