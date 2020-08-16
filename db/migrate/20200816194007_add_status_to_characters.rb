class AddStatusToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :status, :integer
  end
end
