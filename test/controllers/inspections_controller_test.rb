require "test_helper"

class InspectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @site = sites(:one)
    @inspection = inspections(:one)
  end

  test "redirects to login when not authenticated" do
    get all_inspections_url
    assert_redirected_to new_user_session_path
  end

  test "all inspections page renders when logged in" do
    sign_in @user
    get all_inspections_url
    assert_response :success
  end

  test "index renders inspection list for site" do
    sign_in @user
    get site_inspections_url(@site)
    assert_response :success
  end

  test "new renders form" do
    sign_in @user
    get new_site_inspection_url(@site)
    assert_response :success
  end

  test "show renders inspection detail" do
    sign_in @user
    get site_inspection_url(@site, @inspection)
    assert_response :success
  end

  test "create with valid params" do
    sign_in @user
    assert_difference("Inspection.count") do
      post site_inspections_url(@site), params: {
        inspection: {
          inspected_at: Time.current,
          status: "not_started",
          result: "作業完了確認"
        }
      }
    end
    assert_redirected_to site_inspection_url(@site, Inspection.last)
  end

  test "create with invalid params renders new" do
    sign_in @user
    assert_no_difference("Inspection.count") do
      post site_inspections_url(@site), params: {
        inspection: { result: "", inspected_at: "" }
      }
    end
    assert_response :unprocessable_entity
  end

  test "update with valid params" do
    sign_in @user
    patch site_inspection_url(@site, @inspection), params: {
      inspection: { result: "更新後の報告内容" }
    }
    assert_redirected_to site_inspection_url(@site, @inspection)
    assert_equal "更新後の報告内容", @inspection.reload.result
  end

  test "destroy deletes inspection" do
    sign_in @user
    assert_difference("Inspection.count", -1) do
      delete site_inspection_url(@site, @inspection)
    end
    assert_redirected_to site_inspections_url(@site)
  end
end
