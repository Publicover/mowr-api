class User < ApplicationRecord
  has_secure_password
  
  enum role: {
    admin: 0,
    driver: 1,
    customer: 2
  }
end
