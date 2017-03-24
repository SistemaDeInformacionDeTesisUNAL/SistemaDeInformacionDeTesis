class CreateContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :contributions do |t|
      t.string :name
      t.date :publication_date
      t.text :description
      t.references :investigation_group, foreign_key: true

      t.timestamps
    end
  end
end
