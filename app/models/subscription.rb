class Subscription < ApplicationRecord
  belongs_to :job
  belongs_to :candidate

  validates :about_candidate, presence: {message: ' não pode ser em branco'}
end
