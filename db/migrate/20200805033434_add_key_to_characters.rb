class AddKeyToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :foundry_key, :string
  end
end
