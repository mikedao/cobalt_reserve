class AddStatusToCampaigns < ActiveRecord::Migration[6.0]
  def change
    add_column :campaigns, :status, :string
  end
end
