require "test_helper"

class BusinessTripsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @site = sites(:one)
    @trip = business_trips(:one)
  end

  test "redirects to login when not authenticated" do
    get all_business_trips_url
    assert_redirected_to new_user_session_path
  end

  test "all business trips page renders when logged in" do
    sign_in @user
    get all_business_trips_url
    assert_response :success
  end

  test "index renders trip list for site" do
    sign_in @user
    get site_business_trips_url(@site)
    assert_response :success
  end

  test "new renders form" do
    sign_in @user
    get new_site_business_trip_url(@site)
    assert_response :success
  end

  test "show renders trip detail" do
    sign_in @user
    get site_business_trip_url(@site, @trip)
    assert_response :success
  end

  test "create with valid params" do
    sign_in @user
    assert_difference("BusinessTrip.count") do
      post site_business_trips_url(@site), params: {
        business_trip: {
          started_at: Date.today,
          ended_at: Date.today + 1,
          destination: "名古屋",
          purpose: "現地確認"
        }
      }
    end
    assert_redirected_to site_business_trip_url(@site, BusinessTrip.last)
  end

  test "create with invalid params renders new" do
    sign_in @user
    assert_no_difference("BusinessTrip.count") do
      post site_business_trips_url(@site), params: {
        business_trip: { destination: "", purpose: "" }
      }
    end
    assert_response :unprocessable_entity
  end

  test "create rejects ended_at before started_at" do
    sign_in @user
    assert_no_difference("BusinessTrip.count") do
      post site_business_trips_url(@site), params: {
        business_trip: {
          started_at: Date.today,
          ended_at: Date.today - 1,
          destination: "京都",
          purpose: "会議"
        }
      }
    end
    assert_response :unprocessable_entity
  end

  test "update with valid params" do
    sign_in @user
    patch site_business_trip_url(@site, @trip), params: {
      business_trip: { destination: "福岡（更新）" }
    }
    assert_redirected_to site_business_trip_url(@site, @trip)
    assert_equal "福岡（更新）", @trip.reload.destination
  end

  test "destroy deletes trip" do
    sign_in @user
    assert_difference("BusinessTrip.count", -1) do
      delete site_business_trip_url(@site, @trip)
    end
    assert_redirected_to site_business_trips_url(@site)
  end
end
