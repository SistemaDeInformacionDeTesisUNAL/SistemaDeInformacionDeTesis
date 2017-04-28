class CreateStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.integer :state, :null => false, default: 0
      t.references :investigation_group, foreign_key: true

      t.timestamps
    end
  end
end
