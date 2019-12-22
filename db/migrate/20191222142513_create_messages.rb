class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :candidate, foreign_key: true
      t.references :headhunter, foreign_key: true
      t.integer :sent_by

      t.timestamps
    end
  end
end
