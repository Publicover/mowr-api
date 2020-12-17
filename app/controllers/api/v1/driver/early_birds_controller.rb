# frozen_string_literal: true

class Api::V1::Driver::EarlyBirdsController < ApplicationController
  def index
    @early_birds = policy_scope([:api, :v1, EarlyBird])
    authorize [:api, :v1, @early_birds]
    serialized_response(@early_birds, EarlyBird)
  end

  def show
    @early_bird = EarlyBird.find(params[:id])
    authorize [:api, :v1, @early_bird]
    serialized_response(@early_bird, EarlyBird)
  end
end
