class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :job, foreign_key: true
      t.references :candidate, foreign_key: true
      t.string :about_candidate
      t.boolean :featured_profile, default: false
      t.string :deniel_reason

      t.timestamps
    end
  end
end
