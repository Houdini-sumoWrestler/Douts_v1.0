require "test_helper"

class MemberDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get member_dashboard_show_url
    assert_response :success
  end
end
