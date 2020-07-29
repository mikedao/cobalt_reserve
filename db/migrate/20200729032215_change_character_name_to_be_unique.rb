class ChangeCharacterNameToBeUnique < ActiveRecord::Migration[6.0]
  def change
    change_column :characters, :name, :string, unique: true
  end
end
