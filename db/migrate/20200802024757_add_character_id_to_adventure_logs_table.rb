class AddCharacterIdToAdventureLogsTable < ActiveRecord::Migration[6.0]
  def change
    remove_reference :adventure_logs, :user, index: true, foreign_key: true
    add_reference :adventure_logs, :character, null: false, foreign_key: true
  end
end
