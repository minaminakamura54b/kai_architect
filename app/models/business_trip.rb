# app/models/business_trip.rb
class BusinessTrip < ApplicationRecord
  belongs_to :user
  belongs_to :site

  has_many_attached :files

  validates :started_at, :ended_at, :destination, :purpose, presence: true
  validate :end_after_start
  validate :validate_attachments

  private

  def end_after_start
    return unless started_at && ended_at
    errors.add(:ended_at, "は開始日以降にしてください") if ended_at < started_at
  end

  def validate_attachments
    return unless files.attached?

    if files.count > 10
      errors.add(:files, "は10個までです")
    end

    allowed_types = %w[image/jpeg image/png image/gif image/webp application/pdf]
    files.each do |file|
      if file.byte_size > 20.megabytes
        errors.add(:files, "は1ファイル20MB以内にしてください")
      end
      unless allowed_types.include?(file.content_type)
        errors.add(:files, "はJPEG・PNG・GIF・WebP・PDFのみ可能です")
      end
    end
  end
end
