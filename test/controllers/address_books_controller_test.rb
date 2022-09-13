require "test_helper"

class AddressBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get address_books_new_url
    assert_response :success
  end

  test "should get edit" do
    get address_books_edit_url
    assert_response :success
  end
end
