require "test_helper"

class ShiftAssignmentsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get shift_assignments_edit_url
    assert_response :success
  end
end
