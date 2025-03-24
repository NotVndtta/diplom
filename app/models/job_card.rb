class JobCard < ApplicationRecord
  belongs_to :user

  has_many :ratings, as: :rateable, dependent: :destroy
end
