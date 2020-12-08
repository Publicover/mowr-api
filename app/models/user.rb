# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_many :addresses, inverse_of: :user, dependent: :destroy

  validates :email, :f_name, :l_name, :role, presence: true

  enum role: {
    admin: 0,
    driver: 1,
    customer: 2
  }
end
