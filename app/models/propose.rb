class Propose < ApplicationRecord
  belongs_to :candidate
  belongs_to :headhunter
  belongs_to :subscription
end
