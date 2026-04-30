# app/models/business_trip.rb
class BusinessTrip < ApplicationRecord
  belongs_to :user
  belongs_to :site

  validates :started_at, :ended_at, :destination, :purpose, presence: true
  validate :end_after_start

  private

  def end_after_start
    return unless started_at && ended_at
    errors.add(:ended_at, "は開始日以降にしてください") if ended_at < started_at
  end
end