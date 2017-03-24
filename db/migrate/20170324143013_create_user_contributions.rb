class CreateUserContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_contributions do |t|
      t.references :student, foreign_key: true, :null => true
      t.references :teacher, foreign_key: true, :null => true
      t.references :contribution, foreign_key: true, :null => false

      t.timestamps
    end
  end
end
