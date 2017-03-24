class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.string :name, :null => false, :limit => 100
      t.date :publication_date, :null => false
      t.text :description, :limit => 200
      t.references :investigation_group, foreign_key: true, :null => false

      t.integer :state, :null => false, default: 2

      t.integer :state

      t.timestamps
    end
  end
end
