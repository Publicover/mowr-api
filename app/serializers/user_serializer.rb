# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :role, :f_name, :l_name, :created_at, :updated_at
end
