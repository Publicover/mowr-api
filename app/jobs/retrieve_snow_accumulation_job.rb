# frozen_string_literal: true

class RetrieveSnowAccumulationJob < ApplicationJob
  queue_as :default

  # Using the heroku scheduler is ideal.
  # Fire this off at midnight and check it at 4AM
  def perform(zip)
    SnowAccumulation.create!(inches: CurrentSnowfall.new.snowfall(zip))
  end
end
