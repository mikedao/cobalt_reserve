require 'rails_helper'

RSpec.describe 'Admin world news management', type: :feature do
  context 'as an admin user' do
    it 'can create a world news item from the admin dashboard' do
      create(:campaign)
      admin = create(:admin_user)

      login_as_user(admin.username, admin.password)

      visit(admin_dashboard_path)

      click_on 'Create World News Item'

      expect(current_path).to eq(new_admin_world_news_path)

      fill_in :world_news_date, with: 'Some Date'
      fill_in :world_news_title, with: 'Title Goes Here'
      fill_in :world_news_body, with: 'Body'
      click_on 'Create World News'

      expect(current_path).to eq(admin_world_news_index_path)
      expect(page).to have_content('Some Date')
      expect(page).to have_content('Title Goes Here')
    end

    it 'can see all world news items' do
      campaign = create(:campaign)
      admin = create(:admin_user)

      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      login_as_user(admin.username, admin.password)

      visit(admin_dashboard_path)

      click_on 'World News Management'

      expect(page).to have_content(world_news_1.date)
      expect(page).to have_content(world_news_1.title)
      expect(page).to have_content(world_news_2.date)
      expect(page).to have_content(world_news_2.title)
    end

    it 'can see an individual world news item' do
      campaign = create(:campaign)
      admin = create(:admin_user)

      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      login_as_user(admin.username, admin.password)

      visit admin_world_news_index_path

      within("#world-news-#{world_news_1.id}") do
        click_on 'Details'
      end

      expect(current_path).to eq(admin_world_news_path(world_news_1))
      expect(page).to have_content(world_news_1.date)
      expect(page).to have_content(world_news_1.body)
      expect(page).to have_content(world_news_1.title)

      expect(page).to_not have_content(world_news_2.body)
      expect(page).to_not have_content(world_news_2.title)
    end

    it 'can delete a news item from the show page' do
      campaign = create(:campaign)
      admin = create(:admin_user)

      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      login_as_user(admin.username, admin.password)

      visit(admin_world_news_path(world_news_1))

      click_on 'Delete'

      expect(current_path).to eq(admin_world_news_index_path)

      expect(page).to have_content(world_news_2.date)
      expect(page).to have_content(world_news_2.title)

      expect(page).to_not have_content(world_news_1.title)
    end

    it 'can edit a news item from the show page' do
      campaign = create(:campaign)
      admin = create(:admin_user)

      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      login_as_user(admin.username, admin.password)

      visit(admin_world_news_path(world_news_1))

      click_on 'Edit'

      fill_in :world_news_date, with: 'new date'
      fill_in :world_news_title, with: 'new title'
      fill_in :world_news_body, with: 'new_body'

      click_on 'Update Item'

      expect(current_path).to eq(admin_world_news_path(world_news_1))
    end
  end

  context 'as a non admin user' do
    it 'cannot access world news management' do
      campaign = create(:campaign)
      user = create(:user)

      world_news_1 = create(:world_news, campaign: campaign)
      world_news_2 = create(:world_news, campaign: campaign)

      login_as_user(user.username, user.password)

      visit admin_world_news_index_path

      expect(current_path).to eq(root_path)

      visit new_admin_world_news_path

      expect(current_path).to eq(root_path)
    end
  end
end
