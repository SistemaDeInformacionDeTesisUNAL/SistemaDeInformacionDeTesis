class CreateInvestigationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :investigation_groups do |t|
      t.string :name, :null => false, index: true, unique: true, :limit => 25
      t.datetime :create_date, :null => false, index: true
      t.text :description, :limit => 200

      t.timestamps
    end
  end
end
