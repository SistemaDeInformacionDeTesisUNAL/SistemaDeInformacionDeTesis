class CreateEventTeachers < ActiveRecord::Migration[5.0]
  def change
    create_table :event_teachers do |t|
      t.references :event, foreign_key: true
      t.references :teacher, foreign_key: true

      t.timestamps
    end
  end
end
