# frozen_string_literal: true

class EarlyBirdSerializer
  include FastJsonapi::ObjectSerializer
  attributes :user_id, :priority

  belongs_to :user
end