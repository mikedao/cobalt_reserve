require 'rails_helper'

RSpec.describe 'home page has a link to see all world news items' do
  context 'as a visitor' do
    it 'has a link to the world news index' do
      campaign = create(:campaign)
      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      visit root_path
      within ('#world-news') do
        click_on 'World News Archive'
      end

      expect(current_path).to eq(world_news_index_path)
      expect(page).to have_content(world_news_1.date)
      expect(page).to have_content(world_news_1.title)
      expect(page).to have_content(world_news_2.date)
      expect(page).to have_content(world_news_2.title)
    end

    it 'can visit a world news show page' do
      campaign = create(:campaign)
      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      visit world_news_index_path

      within("#news-#{world_news_1.id}") do
        click_link 'Details'
      end

      expect(page).to have_content(world_news_1.title)
      expect(page).to have_content(world_news_1.body)

      expect(page).to_not have_content(world_news_2.title)
      expect(page).to_not have_content(world_news_2.body)
    end
  end
end
