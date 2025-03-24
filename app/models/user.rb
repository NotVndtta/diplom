class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ratings, as: :rateable, dependent: :destroy
  has_many :job_cards, dependent: :destroy
  has_many :experiences, dependent: :destroy
end
