class Propose < ApplicationRecord
  belongs_to :subscription

  validates :start_date, :salary, :benefit, :function, :company_expectation, :bonus, presence: {message: 'não pode ser em branco'}
  validate :verify_valid_start_date, if: :start_date

  def verify_valid_start_date
    if start_date <= Date.today || start_date >= Date.today + 3.months
      errors.add(:start_date, "deve estar em um período de 3 meses, a partir de hoje")
    end
  end
end