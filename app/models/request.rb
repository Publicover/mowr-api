class Request < ApplicationRecord
  belongs_to :user, inverse_of: :requests
  belongs_to :service, inverse_of: :requests
end
