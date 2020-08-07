require 'rails_helper'

RSpec.describe WorldNews, type: :model do
  describe 'relationships' do
    it { should belong_to :campaign }
  end

  describe 'scopes' do
    it 'gives me newest item' do
      campaign = create(:campaign)
      news1 = create(:world_news, campaign: campaign)
      news2 = create(:world_news, campaign: campaign)

      expect(campaign.world_news.most_recently_created).to eq(news2)
    end
  end
end
