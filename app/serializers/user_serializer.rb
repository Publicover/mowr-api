class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :f_name, :l_name, :created_at, :updated_at
end
