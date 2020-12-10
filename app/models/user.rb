# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  has_many :addresses, inverse_of: :user, dependent: :destroy
  has_many :requests, inverse_of: :user, dependent: :nullify
  has_many :services, through: :requests, inverse_of: :user

  has_one :plow, inverse_of: :user, dependent: :destroy

  validates :email, :f_name, :l_name, :role, presence: true

  enum role: {
    admin: 0,
    driver: 1,
    customer: 2
  }
end
