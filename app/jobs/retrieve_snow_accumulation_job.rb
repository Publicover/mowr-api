# frozen_string_literal: true

class RetrieveSnowAccumulationJob < ApplicationJob
  queue_as :default

  # using the heroku scheduler is ideal
  def perform(_zip)
    SnowAccumulation.create!(inches: CurrentSnowfall.new.snowfall(HomeBase.first.zip))
  end
end
