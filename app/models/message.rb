class Message < ApplicationRecord
  belongs_to :candidate
  belongs_to :headhunter

  enum sent_by: [:headhunter, :candidate]

  validates :content, presence: {message: 'não pode ser em branco'}
end
