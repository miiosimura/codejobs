class AddProfileFieldsToCandidates < ActiveRecord::Migration[5.2]
  def change
    add_column :candidates, :name, :string
    add_column :candidates, :birthday, :date
    add_column :candidates, :scholarity, :string
    add_column :candidates, :work_experience, :string
    add_column :candidates, :job_interest, :string
  end
end
