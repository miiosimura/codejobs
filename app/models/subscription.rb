class Subscription < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_one :propose

  validates :about_candidate, presence: {message: ' não pode ser em branco'}
end
