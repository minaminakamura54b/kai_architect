# app/models/site.rb
class Site < ApplicationRecord
    has_many :inspections, dependent: :destroy
    has_many :business_trips, dependent: :destroy

    enum status: { active: 0, completed: 1, suspended: 2 }

    validates :name, presence: true
    validates :address, presence: true
  end