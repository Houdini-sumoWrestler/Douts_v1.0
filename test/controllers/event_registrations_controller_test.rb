require "test_helper"

class EventRegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_registrations_create_url
    assert_response :success
  end

  test "should get destroy" do
    get event_registrations_destroy_url
    assert_response :success
  end
end
