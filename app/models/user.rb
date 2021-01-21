# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password

  phony_normalize :phone, default_country_code: 'US'

  has_many :addresses, inverse_of: :user, dependent: :destroy
  has_many :size_estimates, through: :addresses
  has_many :service_requests, through: :addresses
  has_many :early_birds, through: :addresses
  has_many :payment_methods, inverse_of: :user, dependent: :destroy
  has_many :payments, inverse_of: :user, dependent: :destroy

  has_one :plow, inverse_of: :user, dependent: :destroy

  validates :email, :f_name, :l_name, :role, :phone, presence: true

  enum role: {
    admin: 0,
    driver: 1,
    customer: 2
  }

  def payment_method
    payment_methods.primary.first
  end
end
