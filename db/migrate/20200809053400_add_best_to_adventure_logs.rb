class AddBestToAdventureLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :adventure_logs, :best, :boolean, default: false
  end
end
