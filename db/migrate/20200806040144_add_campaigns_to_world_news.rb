class AddCampaignsToWorldNews < ActiveRecord::Migration[6.0]
  def change
    add_reference :world_news, :campaign, null: false, foreign_key: true
  end
end
