require "test_helper"

class UserTest < ActiveSupport::TestCase
  def valid_user
    User.new(name: "田中太郎", email: "tanaka@example.com", password: "Password1", password_confirmation: "Password1")
  end

  test "valid with all required fields" do
    assert valid_user.valid?
  end

  test "invalid without name" do
    user = valid_user
    user.name = ""
    assert_not user.valid?
    assert user.errors[:name].any?
  end

  test "invalid without email" do
    user = valid_user
    user.email = ""
    assert_not user.valid?
  end

  test "invalid with duplicate email" do
    user = valid_user
    user.email = users(:one).email
    assert_not user.valid?
  end

  test "invalid password without uppercase" do
    user = valid_user
    user.password = "password1"
    user.password_confirmation = "password1"
    assert_not user.valid?
    assert user.errors[:password].any? { |e| e.include?("大文字") }
  end

  test "invalid password without number" do
    user = valid_user
    user.password = "PasswordA"
    user.password_confirmation = "PasswordA"
    assert_not user.valid?
    assert user.errors[:password].any? { |e| e.include?("数字") }
  end

  test "invalid password shorter than 8 chars" do
    user = valid_user
    user.password = "Pass1"
    user.password_confirmation = "Pass1"
    assert_not user.valid?
    assert user.errors[:password].any? { |e| e.include?("8文字") }
  end

  test "has_many inspections and business_trips" do
    user = users(:one)
    assert_respond_to user, :inspections
    assert_respond_to user, :business_trips
  end

  test "default role is worker" do
    user = valid_user
    user.save!
    assert user.worker?
    assert_not user.admin?
  end

  test "admin role can be set" do
    user = valid_user
    user.role = :admin
    user.save!
    assert user.admin?
  end

  test "fixture one is admin" do
    assert users(:one).admin?
  end

  test "fixture two is worker" do
    assert users(:two).worker?
  end
end
