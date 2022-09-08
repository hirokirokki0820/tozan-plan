require "test_helper"

class CompanionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @companion = companions(:one)
  end

  test "should get index" do
    get companions_url
    assert_response :success
  end

  test "should get new" do
    get new_companion_url
    assert_response :success
  end

  test "should create companion" do
    assert_difference("Companion.count") do
      post companions_url, params: { companion: {  } }
    end

    assert_redirected_to companion_url(Companion.last)
  end

  test "should show companion" do
    get companion_url(@companion)
    assert_response :success
  end

  test "should get edit" do
    get edit_companion_url(@companion)
    assert_response :success
  end

  test "should update companion" do
    patch companion_url(@companion), params: { companion: {  } }
    assert_redirected_to companion_url(@companion)
  end

  test "should destroy companion" do
    assert_difference("Companion.count", -1) do
      delete companion_url(@companion)
    end

    assert_redirected_to companions_url
  end
end
