class CreateHistoryGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :history_groups do |t|
      t.date :bonding_date, :null => false
      t.date :exit_date
      t.references :investigation_group, foreign_key: true, :null => false
      t.references :student, foreign_key: true, :null => true
      t.references :teacher, foreign_key: true, :null => true

      t.integer :state, :null => false, default: 0

      t.timestamps
    end
  end
end
