class CreateEventStudents < ActiveRecord::Migration[5.0]
  def change
    create_table :event_students do |t|
      t.references :event, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
