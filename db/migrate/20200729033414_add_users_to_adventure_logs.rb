class AddUsersToAdventureLogs < ActiveRecord::Migration[6.0]
  def change
    add_reference :adventure_logs, :user, null: false, foreign_key: true
  end
end
