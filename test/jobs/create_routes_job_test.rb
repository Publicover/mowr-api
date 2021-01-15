require 'test_helper'

class CreateRoutesJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  setup do
    @base = base_locations(:one)
  end

  test 'job can be queued' do
    assert_enqueued_jobs 0
    CreateRoutesJob.perform_later(@base.zip)
    assert_enqueued_jobs 1
  end

  test 'can assemble routes and create service deliveries' do
    # First, I have to mark the service_deliveries that I already have in the fixtures
    # then I have to fill the service_ids array in the service_requests.
    previous_count = ServiceDelivery.count
    fill_request_service_ids

    # assert_difference doesn't take the kind of math I need to do here.
    VCR.use_cassette('create routes job', allow_playback_repeats: true) do
      CreateRoutesJob.new.perform(99549)
    end
    # Each confirmed service_request gets a new service_delivery every time it snows,
    # so it makes sense to add the existing service_deliveries because they were already
    # generated the last time it snowed. 12 service_deliveries are generated here, so
    # we want the test to reflect a total count of 15.
    assert_equal ServiceRequest.confirmed.count + previous_count, ServiceDelivery.count
  end
end
