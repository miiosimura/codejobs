class CreateProposes < ActiveRecord::Migration[5.2]
  def change
    create_table :proposes do |t|
      t.references :candidate, foreign_key: true
      t.references :headhunter, foreign_key: true
      t.references :subscription, foreign_key: true
      t.datetime :start_date
      t.decimal :salary
      t.string :benefit
      t.string :function
      t.string :company_expectation
      t.string :bonus
      t.boolean :accepted
      t.string :denial_reason

      t.timestamps
    end
  end
end
