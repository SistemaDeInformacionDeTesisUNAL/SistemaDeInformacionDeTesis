class AddImageToInvestigationGroups < ActiveRecord::Migration[5.0]
  def change
    add_column :investigation_groups, :image, :string
  end
end
