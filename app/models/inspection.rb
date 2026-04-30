# app/models/inspection.rb
class Inspection < ApplicationRecord
  belongs_to :site
  belongs_to :user

  enum status: { pending: 0, passed: 1, failed: 2 }

  validates :inspected_at, presence: true
  validates :result, presence: true
end