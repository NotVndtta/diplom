class JobCard < ApplicationRecord
  include PgSearch::Model

  belongs_to :user

  has_one :accepted_application, -> { accepted }, class_name: "JobApplication"
  has_one :executor, through: :accepted_application, source: :user

  has_many :job_applications, dependent: :destroy
  has_many :applicants, through: :job_applications, source: :user
  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :job_card_media, class_name: "JobCardMedia", dependent: :destroy
  has_many :media_files, through: :job_card_media

  enum :status, { active: "active", archived: "archived" }, default: :active

  validates :farm_name, presence: true, length: { maximum: 255 }
  validates :work_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :location, presence: true
  validates :remuneration, presence: true, numericality: { greater_than: 0 }
  validates :date_at, presence: true
  validate :date_cannot_be_in_the_past
  validate :accepted_applications_within_work_amount

  def self.ransackable_associations(auth_object = nil)
    [ "user" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "count_users", "created_at", "date_at", "description", "farm_name", "id", "location", "remuneration", "status", "updated_at", "work_amount" ]
  end

  pg_search_scope :search_by_text,
                  against: [ :farm_name, :location, :description ],
                  associated_against: { user: :name },
                  using: {
                    tsearch: { prefix: true }
                  }

  private

  def date_cannot_be_in_the_past
    if date_at.present? && date_at < Date.current
      errors.add(:date_at, "не может быть в прошлом")
    end
  end

  def accepted_applications_within_work_amount
    return if work_amount.blank?
    if job_applications.accepted.count > work_amount
      errors.add(:base, "Количество принятых рабочих не может превышать #{work_amount}")
    end
  end
end
