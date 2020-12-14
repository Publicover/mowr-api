# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  phony_normalize :phone, default_country_code: 'US'

  has_many :addresses, inverse_of: :user, dependent: :destroy

  has_one :plow, inverse_of: :user, dependent: :destroy

  validates :email, :f_name, :l_name, :role, :phone, presence: true
  # validates_format_of :phone,
  #                     with: /\(?[0-9]{3}\)?-[0-9]{3}-[0-9]{4}/,
  #                     message: "Phone numbers must be in xxx-xxx-xxxx format."

  enum role: {
    admin: 0,
    driver: 1,
    customer: 2
  }
end
