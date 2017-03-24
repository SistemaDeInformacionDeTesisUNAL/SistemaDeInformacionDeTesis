class CreateInvestigationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :investigation_groups do |t|
      t.string :name, :null => false, :default => "", unique: true, :limit => 25
      t.date :create_date, :null => false
      t.text :description, :limit => 200

      t.timestamps
    end
  end
end
