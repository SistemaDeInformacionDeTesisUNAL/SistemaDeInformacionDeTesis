class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name, :null => false, index: true, unique: true, :limit => 45
      t.datetime :date_time, :null => false, index: true
      t.text :description, :limit => 200
      t.references :investigation_group, index: true, foreign_key: true

      t.timestamps
    end

  end
end
