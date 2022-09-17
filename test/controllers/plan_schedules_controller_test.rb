require "test_helper"

class PlanSchedulesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plan_schedules_new_url
    assert_response :success
  end

  test "should get edit" do
    get plan_schedules_edit_url
    assert_response :success
  end
end
