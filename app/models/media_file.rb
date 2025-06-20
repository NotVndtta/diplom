class MediaFile < ApplicationRecord
  mount_uploader :file, FileUploader

  belongs_to :user

  has_many :job_card_media, class_name: "JobCardMedia", dependent: :destroy
  has_many :job_cards, through: :job_card_media

  validates :file, presence: true
end
