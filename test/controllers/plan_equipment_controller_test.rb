require "test_helper"

class PlanEquipmentControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get plan_equipment_new_url
    assert_response :success
  end

  test "should get edit" do
    get plan_equipment_edit_url
    assert_response :success
  end
end
