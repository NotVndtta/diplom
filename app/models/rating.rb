class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :rateable, polymorphic: true

  validates :comment, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :grade, presence: true, inclusion: { in: 1..5 }
  validates :user_id, presence: true
  validates :rateable, presence: true

  # Пользователь может оставить только один отзыв для конкретного объекта
  validates :user_id, uniqueness: { scope: [ :rateable_type, :rateable_id ],
    message: "уже оставил отзыв для этого объекта" }
end
