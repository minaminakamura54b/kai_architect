require "test_helper"

class InspectionTest < ActiveSupport::TestCase
  def valid_inspection
    Inspection.new(
      site: sites(:one),
      user: users(:one),
      inspected_at: Time.current,
      status: :not_started,
      result: "異常なし"
    )
  end

  test "valid with all required fields" do
    assert valid_inspection.valid?
  end

  test "invalid without inspected_at" do
    inspection = valid_inspection
    inspection.inspected_at = nil
    assert_not inspection.valid?
    assert inspection.errors[:inspected_at].any?
  end

  test "invalid without result" do
    inspection = valid_inspection
    inspection.result = ""
    assert_not inspection.valid?
    assert inspection.errors[:result].any?
  end

  test "invalid without site" do
    inspection = valid_inspection
    inspection.site = nil
    assert_not inspection.valid?
  end

  test "invalid without user" do
    inspection = valid_inspection
    inspection.user = nil
    assert_not inspection.valid?
  end

  test "status enum values" do
    inspection = valid_inspection
    inspection.status = :not_started
    assert inspection.not_started?
    inspection.status = :in_progress
    assert inspection.in_progress?
    inspection.status = :completed
    assert inspection.completed?
  end

  test "remarks is optional" do
    inspection = valid_inspection
    inspection.remarks = nil
    assert inspection.valid?
  end
end
