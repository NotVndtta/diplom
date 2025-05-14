class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :rateable, polymorphic: true

  validates :comment, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :grade, presence: true, inclusion: { in: 1..5 }
  validates :user_id, presence: true
  validates :rateable, presence: true
end
