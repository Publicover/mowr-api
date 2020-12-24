class CreateRoutes < ApplicationJob
  queue_as :default

  # def perform(zip)
  #   if SnowAccumulation.last.inches > 0
  #     if CurrentSnowfall.new.snowfall(BaseLocation.last.zip) > 1
  #       CalculateDailyRoute.new.perform_with_early_birds
  #     end
  #   end
  # end
end
