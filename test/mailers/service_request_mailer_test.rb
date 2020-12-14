require 'test_helper'

class ServiceReqeustMailerTest < ActionMailer::TestCase
  setup do
    @customer = users(:three)
  end

  test 'service request created' do
    assert_enqueued_emails 0
    ServiceRequestMailer.service_request_confirmation(@customer).deliver_later
    assert_enqueued_emails 1
  end
end
