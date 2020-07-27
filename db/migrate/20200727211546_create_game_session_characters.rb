class CreateGameSessionCharacters < ActiveRecord::Migration[6.0]
  def change
    create_table :game_session_characters do |t|
      t.references :game_session, null: false, foreign_key: true
      t.references :character, null: false, foreign_key: true

      t.timestamps
    end
  end
end
