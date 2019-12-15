class Candidate < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :verify_valid_birthday, if: :birthday

  def verify_profile_fields?
    if !(name.blank? || birthday.blank? || scholarity.blank? || work_experience.blank? || job_interest.blank?)
      'Oba! Você está pronto para se candidatar! :D'
    else
      'Complete seu perfil para começar a se candidatar :)'
    end
  end

  def verify_valid_birthday
    if birthday > Date.today || birthday < '1900-01-01'.to_date
      errors.add(:birthday, " inválida")
    end
  end

end
