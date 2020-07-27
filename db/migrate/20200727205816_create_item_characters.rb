class CreateItemCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :item_characters do |t|
      t.references :item, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
