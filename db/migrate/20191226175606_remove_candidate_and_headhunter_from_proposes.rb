class RemoveCandidateAndHeadhunterFromProposes < ActiveRecord::Migration[5.2]
  def change
    remove_reference :proposes, :candidate, foreign_key: true
    remove_reference :proposes, :headhunter, foreign_key: true
  end
end
