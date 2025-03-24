class JobCard < ApplicationRecord
  has_many :ratings, as: :rateable, dependent: :destroy
end
