class JobCard < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy
  has_many :applicants, through: :job_applications, source: :user
  has_one :accepted_application, -> { accepted }, class_name: "JobApplication"
  has_one :executor, through: :accepted_application, source: :user
  has_many :ratings, as: :rateable, dependent: :destroy

  validates :farm_name, presence: true, length: { maximum: 255 }
  validates :work_amount, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :description, presence: true, length: { maximum: 1000 }
  validate :accepted_applications_within_work_amount

  private

  def accepted_applications_within_work_amount
    if job_applications.accepted.count > work_amount
      errors.add(:base, "Количество принятых рабочих не может превышать #{work_amount}")
    end
  end
end