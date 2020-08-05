class AddBackstoryToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :age, :string
    add_column :characters, :early_life, :text
    add_column :characters, :moral_code, :text
    add_column :characters, :personality, :text
    add_column :characters, :fears, :text
    add_column :characters, :role, :text
    add_column :characters, :additional_information, :text
  end
end
