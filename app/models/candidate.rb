class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subscriptions
  has_many :messages
  has_one_attached :photo

  validate :verify_valid_birthday, if: :birthday

  def verified_profile?
    !(name.blank? || birthday.blank? || scholarity.blank? || work_experience.blank? || job_interest.blank?)
  end

  def verify_valid_birthday
    if birthday > Date.today || birthday < '1900-01-01'.to_date
      errors.add(:birthday, " inválida")
    end
  end

end
