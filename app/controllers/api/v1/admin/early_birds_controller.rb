# frozen_string_literal: true

class Api::V1::Admin::EarlyBirdsController < ApplicationController
  before_action :set_early_bird, except: %i[index create]

  def index
    @early_birds = policy_scope([:api, :v1, EarlyBird])
    authorize [:api, :v1, @early_birds]
    serialized_response(@early_birds)
  end

  def show
    serialized_response(@early_bird)
  end

  def create
    @early_bird = EarlyBird.new(early_bird_params)
    authorize [:api, :v1, @early_bird]

    serialized_response(@early_bird) if @early_bird.save
  end

  def update
    @early_bird.update(early_bird_params)
    serialized_response(@early_bird)
  end

  def destroy
    @early_bird.destroy
    serialized_response(@early_bird)
  end

  private

    def set_early_bird
      @early_bird = EarlyBird.find(params[:id])
      authorize [:api, :v1, @early_bird]
    end

    def early_bird_params
      params.require(:early_bird).permit(policy([:api, :v1, EarlyBird]).permitted_attributes)
    end
end
