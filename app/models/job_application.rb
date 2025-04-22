class JobApplication < ApplicationRecord
  belongs_to :job_card
  belongs_to :user

  STATUSES = [
    PENDING = "pending",
    ACCEPTED = "accepted",
    REJECTED = "rejected"
  ].freeze

  STATUSES_ENUM = STATUSES.to_h{ |status| [status.to_sym, status] }.freeze

  enum :status, STATUSES_ENUM

  validates :job_card_id, uniqueness: { scope: :user_id, message: "You have already applied to this job" }
  validates :status, inclusion: { in: STATUSES }

  scope :pending, -> { where(status: PENDING) }
  scope :accepted, -> { where(status: ACCEPTED) }
  scope :rejected, -> { where(status: REJECTED) }
end