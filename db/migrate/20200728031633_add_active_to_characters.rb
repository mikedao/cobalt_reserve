class AddActiveToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :active, :boolean, default: false
  end
end
