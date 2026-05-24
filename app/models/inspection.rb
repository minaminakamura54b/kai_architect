# app/models/inspection.rb
class Inspection < ApplicationRecord
  belongs_to :site
  belongs_to :user

  has_many_attached :files

  enum status: { not_started: 0, in_progress: 1, completed: 2 }, _default: :not_started

  validates :inspected_at, presence: true
  validates :result, presence: true
  validate :validate_attachments

  private

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
