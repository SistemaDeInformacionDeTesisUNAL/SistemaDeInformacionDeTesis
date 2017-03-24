class CreateTeacherInvestigationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :teacher_investigation_groups do |t|
      t.references :teacher, foreign_key: true
      t.references :investigation_group, foreign_key: true
      t.integer :rol

      t.timestamps
    end
  end
end
