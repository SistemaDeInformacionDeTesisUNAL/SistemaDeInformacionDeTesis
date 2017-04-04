class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.string :entity, :null => false
      t.text :URL, :null => false, unique: true
      t.references :profileable, polymorphic: true

      t.timestamps
    end
  end
end
