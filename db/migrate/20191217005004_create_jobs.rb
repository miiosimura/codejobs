class CreateJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :jobs do |t|
      t.references :headhunter, foreign_key: true
      t.string :title
      t.string :job_description
      t.string :skills_description
      t.decimal :salary_min
      t.decimal :salary_max
      t.string :job_level
      t.date :subscription_date
      t.string :city
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
