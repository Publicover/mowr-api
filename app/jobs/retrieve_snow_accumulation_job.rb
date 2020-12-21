class RetrieveSnowAccumulationJob < ApplicationJob
  queue_as :default

  # using the heroku scheduler is ideal
  def perform(zip)
    SnowAccumulation.create!(inches: CurrentSnowfall.new.snowfall(HomeBase.first.zip))
  end
end
