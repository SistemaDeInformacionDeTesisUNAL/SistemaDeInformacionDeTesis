class AddFileToContribution < ActiveRecord::Migration[5.0]
  def change
    add_column :contributions, :file, :string
  end
end
