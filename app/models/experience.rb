class Experience < ApplicationRecord
  belongs_to :user

  validates :start_date_at, :end_date_at, presence: true
  validates :description, presence: true, length: { minimum: 3, maximum: 255 }
  validates :company, presence: true, length: { maximum: 255 }
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date_at.blank? || start_date_at.blank?

    if end_date_at < start_date_at
      errors.add(:end_date_at, "должна быть позже или равна дате начала")
    end
  end
end
