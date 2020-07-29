class AddGameSessionsToAdventureLogs < ActiveRecord::Migration[6.0]
  def change
    add_reference :adventure_logs, :game_session, null: false, foreign_key: true
  end
end
