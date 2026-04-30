class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :inspections, dependent: :destroy
  has_many :business_trips, dependent: :destroy

  validates :name, presence: true

  validate :password_complexity, if: -> { password.present? }

  private

  def password_complexity
    return if password.blank?
    unless password.length >= 8
      errors.add(:password, "は8文字以上で入力してください")
      return
    end
    unless password.match?(/[A-Z]/)
      errors.add(:password, "には大文字を1文字以上含めてください")
    end
    unless password.match?(/[0-9]/)
      errors.add(:password, "には数字を1文字以上含めてください")
    end
  end
end
