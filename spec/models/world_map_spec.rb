require 'rails_helper'

RSpec.describe WorldMap, type: :model do
  describe 'relationships' do
    it { should belong_to :campaign }
  end

  describe 'scopes' do
    it '.latest_map' do
      campaign = create(:campaign)
      map1 = create(:world_map, campaign: campaign)
      map2 = create(:world_map, campaign: campaign)
      map3 = create(:world_map, campaign: campaign)

      expect(WorldMap.latest_map).to eq(map3)
      expect(WorldMap.latest_map).to_not eq(map2)
      expect(WorldMap.latest_map).to_not eq(map1)
    end
  end
end
