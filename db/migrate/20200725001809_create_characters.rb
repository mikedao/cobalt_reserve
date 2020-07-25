class CreateCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :race
      t.integer :level
      t.string :character_class

      t.timestamps
    end
  end
end
