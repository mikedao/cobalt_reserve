class ChangeCharactersTable < ActiveRecord::Migration[6.0]
  def change
    rename_column :characters, :character_class, :klass
    remove_column :characters, :species

    add_reference :characters, :ancestryone, null: false
    add_reference :characters, :ancestrytwo, null: true
    add_reference :characters, :culture, null: false
  end
end
