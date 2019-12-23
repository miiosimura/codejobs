class ChangeColumnNameDenielToDenial < ActiveRecord::Migration[5.2]
  def change
    rename_column :subscriptions, :deniel_reason, :denial_reason
  end
end
