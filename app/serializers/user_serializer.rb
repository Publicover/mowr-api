# frozen_string_literal: true



# TODO: include all relations in all serializers
class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :email, :role, :f_name, :l_name, :stripe_id, :created_at, :updated_at

  has_many :addresses
end
