require 'rails_helper'

RSpec.describe Campaign, type: :model do
  describe 'relationships' do
    it { should have_many :characters }
    it { should have_many :game_sessions }
    it { should have_many :world_news }
    it { should have_many :world_maps }
  end

  describe 'class methods' do
    it '.current' do
      campaign1 = Campaign.create(name: 'First', status: 'inactive')
      campaign2 = Campaign.create(name: 'Second Campaign', status: 'active')

      expect(Campaign.current).to eq(campaign2)

      campaign3 = Campaign.create(name: 'Third', status: 'active')

      expect(Campaign.current).to eq(campaign2)
    end
  end

  describe 'instance methods' do
    it '#latest_low_res' do
      campaign = create(:campaign)

      map1 = create(:world_map, campaign: campaign)
      map2 = create(:world_map, campaign: campaign)
      map3 = create(:world_map, campaign: campaign)

      expect(campaign.latest_low_res).to eq(map3.low_res)
    end

    it '#latest_high_res' do
      campaign = create(:campaign)

      map1 = create(:world_map, campaign: campaign)
      map2 = create(:world_map, campaign: campaign)
      map3 = create(:world_map, campaign: campaign)

      expect(campaign.latest_high_res).to eq(map3.high_res)
    end

    it '#heroes' do
      campaign = create(:campaign)
      user = create(:user)
      dead_1 = create(:dead_character, user: user, campaign: campaign)
      dead_2 = create(:dead_character, user: user, campaign: campaign)
      alive = create(:character, user: user)

      expect(campaign.heroes).to include(dead_1)
      expect(campaign.heroes).to include(dead_2)
      expect(campaign.heroes).to_not include(alive)
    end
  end
end
