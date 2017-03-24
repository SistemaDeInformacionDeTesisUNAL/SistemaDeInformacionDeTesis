class CreateTagContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_contributions do |t|
      t.references :tag, foreign_key: true
      t.references :contribution, foreign_key: true

      t.timestamps
    end
  end
end
