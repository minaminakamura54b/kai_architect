require "test_helper"

class SiteTest < ActiveSupport::TestCase
  def valid_site
    Site.new(name: "新テスト現場", address: "大阪府大阪市1-1")
  end

  test "valid with name and address" do
    assert valid_site.valid?
  end

  test "invalid without name" do
    site = valid_site
    site.name = ""
    assert_not site.valid?
    assert site.errors[:name].any?
  end

  test "invalid without address" do
    site = valid_site
    site.address = ""
    assert_not site.valid?
    assert site.errors[:address].any?
  end

  test "status enum values" do
    site = valid_site
    site.status = :active
    assert site.active?
    site.status = :completed
    assert site.completed?
    site.status = :suspended
    assert site.suspended?
  end

  test "has_many inspections and business_trips" do
    site = sites(:one)
    assert_respond_to site, :inspections
    assert_respond_to site, :business_trips
  end

  test "destroying site destroys associated inspections and business_trips" do
    site = sites(:one)
    inspection_count = site.inspections.count
    trip_count = site.business_trips.count
    site.destroy
    assert_equal 0, Inspection.where(site: site).count
    assert_equal 0, BusinessTrip.where(site: site).count
  end
end
