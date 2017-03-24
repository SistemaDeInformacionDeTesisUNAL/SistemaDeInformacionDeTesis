class CreateHistoryGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :history_groups do |t|
      t.date :bonding_date
      t.date :exit_date
      t.references :investigation_group, foreign_key: true
      t.references :student, foreign_key: true
      t.references :teacher, foreign_key: true

      t.integer :state

      t.timestamps
    end
  end
end
