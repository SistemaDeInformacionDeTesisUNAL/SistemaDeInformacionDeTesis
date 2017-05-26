class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.string :name, :null => false, :limit => 100
      t.datetime :publication_date
      t.text :description, :limit => 200
      t.integer :state, :null => false, default: 2

      t.references :investigation_group, foreign_key: true

      t.timestamps
    end
  end
end
