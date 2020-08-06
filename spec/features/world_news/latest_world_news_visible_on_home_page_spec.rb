require 'rails_helper'

RSpec.describe 'Wwrld News appears on root page', type: :feature do
  context 'as a visitor' do
    it 'shows latest world news on home page' do
      campaign = create(:campaign)
      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      visit root_path

      expect(page).to_not have_content(world_news_1.date)
      expect(page).to_not have_content(world_news_1.body)
      expect(page).to_not have_content(world_news_1.title)

      expect(page).to have_content(world_news_2.date)
      expect(page).to have_content(world_news_2.body)
      expect(page).to have_content(world_news_2.title)
    end
  end
end
