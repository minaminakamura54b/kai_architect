require "test_helper"

class BusinessTripTest < ActiveSupport::TestCase
  def valid_trip
    BusinessTrip.new(
      site: sites(:one),
      user: users(:one),
      started_at: Date.today,
      ended_at: Date.today + 1,
      destination: "大阪",
      purpose: "顧客打ち合わせ"
    )
  end

  test "valid with all required fields" do
    assert valid_trip.valid?
  end

  test "valid when started_at equals ended_at (same day trip)" do
    trip = valid_trip
    trip.ended_at = trip.started_at
    assert trip.valid?
  end

  test "invalid without started_at" do
    trip = valid_trip
    trip.started_at = nil
    assert_not trip.valid?
    assert trip.errors[:started_at].any?
  end

  test "invalid without ended_at" do
    trip = valid_trip
    trip.ended_at = nil
    assert_not trip.valid?
    assert trip.errors[:ended_at].any?
  end

  test "invalid without destination" do
    trip = valid_trip
    trip.destination = ""
    assert_not trip.valid?
    assert trip.errors[:destination].any?
  end

  test "invalid without purpose" do
    trip = valid_trip
    trip.purpose = ""
    assert_not trip.valid?
    assert trip.errors[:purpose].any?
  end

  test "invalid when ended_at is before started_at" do
    trip = valid_trip
    trip.ended_at = trip.started_at - 1
    assert_not trip.valid?
    assert trip.errors[:ended_at].any?
  end

  test "expenses is optional" do
    trip = valid_trip
    trip.expenses = nil
    assert trip.valid?
  end

  test "report is optional" do
    trip = valid_trip
    trip.report = nil
    assert trip.valid?
  end
end
