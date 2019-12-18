class Job < ApplicationRecord
  belongs_to :headhunter

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
