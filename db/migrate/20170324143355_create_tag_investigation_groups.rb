class CreateTagInvestigationGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :tag_investigation_groups do |t|
      t.references :tag, foreign_key: true
      t.references :investigationGroup, foreign_key: true

      t.timestamps
    end
  end
end
