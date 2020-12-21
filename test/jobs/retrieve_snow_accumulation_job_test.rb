require 'test_helper'

class BlockUnconfirmedDeliveryJobTest < ActiveJob::TestCase
  include ActiveJob::TestHelper

  setup do
    @base = base_locations(:one)
  end

  test 'job can be queued' do
    assert_enqueued_jobs 0
    RetrieveSnowAccumulationJob.perform_later(@base.zip)
    assert_enqueued_jobs 1
  end
end
