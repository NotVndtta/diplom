class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  ROLES = [
    FREELANCER = "freelancer",
    FOREMAN = "foreman",
    ADMIN = "admin"
  ].freeze

  ROLES_ENUM = ROLES.to_h { |role| [ role.to_sym, role ] }.freeze

  enum :role, ROLES_ENUM

  scope :with_jobs, -> { joins(:job_cards).distinct }

  has_one :foreman_description, dependent: :destroy

  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :job_cards, dependent: :destroy
  has_many :job_applications, dependent: :destroy
  has_many :applied_jobs, through: :job_applications, source: :job_card
  has_many :experiences, dependent: :destroy
  has_many :media_files

  validates :first_name, presence: true, length: { maximum: 100 }
  validates :last_name, presence: true, length: { maximum: 100 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, allow_blank: true, format: { with: /\A\+?[0-9\s\-\(\)]*\z/, message: "is not a valid phone number" }
  validates :birth_year, presence: true, numericality: { only_integer: true, greater_than: 1900, less_than_or_equal_to: Date.current.year }
  validates :city, presence: true, length: { maximum: 100 }
  validates :role, presence: true, inclusion: { in: ROLES }
  validates :about, length: { maximum: 360 }

  def name
    "#{first_name} #{last_name}"
  end
end
