# frozen_string_literal: true

class RetrieveSnowAccumulationJob < ApplicationJob
  queue_as :default

  # using the heroku scheduler is ideal
  # fire off at midnight, check it at 4AM
  def perform(zip)
    SnowAccumulation.create!(inches: CurrentSnowfall.new.snowfall(zip))
  end
end
