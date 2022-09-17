require "test_helper"

class PlanEscapesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plan_escapes_new_url
    assert_response :success
  end

  test "should get edit" do
    get plan_escapes_edit_url
    assert_response :success
  end
end
