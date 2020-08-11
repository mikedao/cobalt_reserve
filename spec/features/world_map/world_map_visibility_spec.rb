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

      within('#world-map') do
        expect(page).to have_link('High Res Version', href: 'https://i.imgur.com/zPIS6Ig.jpg')
      end
    end

    it 'can see all of the previous world_maps' do
      campaign = create(:campaign)
      world_map = create(:world_map, campaign: campaign)
      world_map2 = create(:world_map, campaign: campaign)
      world_map3 = create(:world_map, campaign: campaign)
      visit root_path

      within('#world-map') do
        click_on 'Map History'
      end

      expect(current_path).to eq(world_maps_path)

      within('#map-0') do
        expect(page).to have_content(world_map3.created_at.strftime('%A, %B %e %Y'))
        expect(page).to have_link('High Res Version', href: 'https://i.imgur.com/zPIS6Ig.jpg')
        expect(page).to have_link('Low Res Version', href: 'https://i.imgur.com/rBxkv0D.jpg')
      end
    end
  end

  context 'as an admin' do
    it 'can add a new world map from the dashboard' do
      campaign = create(:campaign)
      admin = create(:admin_user)

      login_as_user(admin.username, admin.password)
      visit admin_dashboard_path

      click_on 'Add New World Map'

      expect(current_path).to eq(admin_world_maps_new_path)

      fill_in :world_map_low_res, with: 'https://i.imgur.com/JTXgJPB.jpg'
      fill_in :world_map_high_res, with: 'https://i.imgur.com/zPIS6Ig.jpg'

      click_on 'Create New World Map'

      expect(current_path).to eq(admin_dashboard_path)

      visit root_path

      expect(page).to have_css("img[src*='JTXgJPB.jpg']")
    end
  end
end
