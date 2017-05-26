class AddUbicationToContribution < ActiveRecord::Migration[5.0]
  def change
    add_column :contributions, :ubication, :string
  end
end
