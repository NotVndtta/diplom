class ForemanDescription < ApplicationRecord
  belongs_to :user

  validates :farm_name, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 3, maximum: 1000 }
end
