class AddCampaignsToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_reference :characters, :campaign, null: false, foreign_key: true
  end
end
