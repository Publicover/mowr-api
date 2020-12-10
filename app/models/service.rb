class Service < ApplicationRecord
  has_many :requests, inverse_of: :service, dependent: :nullify
  has_many :users, through: :requests, inverse_of: :services, dependent: :nullify
end
