class Job < ApplicationRecord
  belongs_to :headhunter
  has_many :subscriptions

  validates :title, :job_description, :skills_description, :salary_min, :salary_max, :job_level, :subscription_date, :city, presence: {message: 'não pode ser em branco'}

  validate :verify_valid_subscription_date, if: :subscription_date
  validate :verify_salary_min_max, if: :salary_max

  enum status: [:active, :finished]

  def verify_valid_subscription_date
    if subscription_date <= Date.today
      errors.add(:subscription_date, " inválida.")
    end
  end

  def verify_salary_min_max
    if salary_max < salary_min
      errors.add(:salary_max, ' deve ser maior que Salary min')
    end
  end
end
