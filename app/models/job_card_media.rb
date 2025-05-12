class JobCardMedia < ApplicationRecord
  belongs_to :job_card
  belongs_to :media_file

  validates :job_card_id, :media_file_id, presence: true
  validates :media_file_id, uniqueness: { scope: :job_card_id, message: "уже привязан к этой агрооперации" }
end
