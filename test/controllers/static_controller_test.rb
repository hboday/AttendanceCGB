require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get reports" do
    get static_reports_url
    assert_response :success
  end
end
