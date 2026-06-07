require "test_helper"

class EventAssetsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_assets_create_url
    assert_response :success
  end

  test "should get destroy" do
    get event_assets_destroy_url
    assert_response :success
  end
end
