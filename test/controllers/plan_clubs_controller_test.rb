require "test_helper"

class PlanClubsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plan_clubs_new_url
    assert_response :success
  end

  test "should get edit" do
    get plan_clubs_edit_url
    assert_response :success
  end
end
