class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.date :date
      t.time :time
      t.text :description
      t.references :investigation_group, foreign_key: true

      t.timestamps
    end
  end
end
