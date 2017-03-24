class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.string :name, :null => false, unique: true, :limit => 15
      t.text :description, :limit => 200

      t.timestamps
    end
  end
end
