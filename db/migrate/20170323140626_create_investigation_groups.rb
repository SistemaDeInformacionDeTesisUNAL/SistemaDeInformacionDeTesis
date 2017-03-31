class CreateInvestigationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :investigation_groups do |t|
      t.string :name, :null => false, :default => "", index: true,unique: true, :limit => 25
      t.date :create_date, :null => false, index: true
      t.text :description, :limit => 200

      t.timestamps
    end
    change_table :investigation_groups do  |t|
      t.index :name
      t.index :create_date
    end
  end
end
