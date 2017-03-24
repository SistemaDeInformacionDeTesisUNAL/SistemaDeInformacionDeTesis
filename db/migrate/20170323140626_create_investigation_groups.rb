class CreateInvestigationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :investigation_groups do |t|
      t.string :name
      t.date :createDate
      t.text :description

      t.timestamps
    end
  end
end
