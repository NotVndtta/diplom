class JobCardMedia < ApplicationRecord
  belongs_to :job_card
  belongs_to :media_file

  validates :job_card_id, :media_file_id, presence: true
end
