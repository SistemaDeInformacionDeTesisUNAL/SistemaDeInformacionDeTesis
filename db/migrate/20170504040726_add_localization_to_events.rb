class AddLocalizationToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :localization, :string
  end
end
