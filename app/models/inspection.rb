# app/models/inspection.rb
class Inspection < ApplicationRecord
  belongs_to :site
  belongs_to :user

  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  validates :inspected_at, presence: true
  validates :result, presence: true
end