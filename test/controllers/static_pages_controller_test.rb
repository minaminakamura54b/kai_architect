require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "redirects to login when not authenticated" do
    get root_url
    assert_redirected_to new_user_session_path
  end

  test "home renders dashboard when logged in" do
    sign_in users(:one)
    get root_url
    assert_response :success
  end
end
