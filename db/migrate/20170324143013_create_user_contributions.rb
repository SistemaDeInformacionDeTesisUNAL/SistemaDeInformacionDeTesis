class CreateUserContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_contributions do |t|
      t.references :userable, polymorphic: true
      t.references :contribution, foreign_key: true

      t.timestamps
    end
  end
end
