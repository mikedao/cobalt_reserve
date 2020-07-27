class AddCampaignsToGameSessions < ActiveRecord::Migration[6.0]
  def change
    add_reference :game_sessions, :campaign, null: false, foreign_key: true
  end
end
