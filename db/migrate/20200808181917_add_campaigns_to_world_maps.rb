class AddCampaignsToWorldMaps < ActiveRecord::Migration[6.0]
  def change
    add_reference :world_maps, :campaign, null: false, foreign_key: true
  end
end
