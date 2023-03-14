require "test_helper"

class TestControllerTest < ActionDispatch::IntegrationTest
  test "should get v1" do
    get test_v1_url
    assert_response :success
  end

  test "should get v2" do
    get test_v2_url
    assert_response :success
  end

  test "should get v3" do
    get test_v3_url
    assert_response :success
  end
end
