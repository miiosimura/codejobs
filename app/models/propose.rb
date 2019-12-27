class Propose < ApplicationRecord
  belongs_to :subscription

  validates :start_date, :salary, :benefit, :function, :company_expectation, :bonus, presence: {message: 'não pode ser em branco'}
  validate :verify_valid_start_date, if: :start_date

  def verify_valid_start_date
    if start_date <= Date.today
      errors.add(:start_date, " inválida.")
    end
  end
end