require 'rails_helper'

RSpec.describe 'low res world map appears on home page', type: :feature do
  context 'as a visitor' do
    it 'when I visit the home page, i see the low res version of the map' do
      campaign = create(:campaign)
      world_map = create(:world_map, campaign: campaign)
      visit root_path

      within('#world-map') do
        expect(page).to have_css("img[src*='rBxkv0D.jpg']")
      end
    end

    it 'has a link to the high res version on the home page' do
      campaign = create(:campaign)
      world_map = create(:world_map, campaign: campaign)
      visit root_path

      save_and_open_page
      within('#world-map') do
        expect(page).to have_link('High Res Version', href: 'https://i.imgur.com/zPIS6Ig.jpg')
      end
    end
  end
end
