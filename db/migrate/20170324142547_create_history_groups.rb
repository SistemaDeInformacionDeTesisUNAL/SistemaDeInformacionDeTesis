class CreateHistoryGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :history_groups do |t|
      t.date :bonding_date, :null => false
      t.date :exit_date
      t.integer :state, :null => false, default: 0
      t.references :investigation_group, foreign_key: true, :null => false
      t.references :historable, polymorphic: true
      t.timestamps
    end
  end
end
