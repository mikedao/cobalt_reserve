require 'rails_helper'

RSpec.describe 'Admin Campaign Management', type: :feature do
  context 'as an admin user' do
    it 'can get to the campaign management page from the dashboard' do
      campaign = create(:campaign)
      inactive_campaign = create(:inactive_campaign)
      admin = create(:admin_user)

      login_as_user(admin.username, admin.password)

      visit admin_dashboard_path

      click_on 'Campaign Management'

      expect(current_path).to eq(admin_campaigns_path)
      expect(page).to have_content(campaign.name)
      expect(page).to have_content(inactive_campaign.name)
    end

    it 'can access a campaign show page' do
      campaign = create(:campaign)
      inactive_campaign = create(:inactive_campaign)
      admin = create(:admin_user)

      login_as_user(admin.username, admin.password)

      visit admin_campaigns_path

      within("#campaign-#{campaign.id}") do
        click_on campaign.name
      end

      expect(current_path).to eq(admin_campaign_path(campaign))
      expect(page).to have_content(campaign.name)
      expect(page).to_not have_content(inactive_campaign.name)
    end

    it 'can edit a campaign name' do
      campaign = create(:campaign)
      admin = create(:admin_user)
      old_name = campaign.name

      login_as_user(admin.username, admin.password)

      visit admin_campaigns_path

      within("#campaign-#{campaign.id}") do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_admin_campaign_path(campaign))
      fill_in :campaign_name, with: 'new name'

      click_on 'Update Campaign'

      expect(current_path).to eq(admin_campaign_path(campaign))
      expect(page).to have_content('new name')
      expect(page).to_not have_content(old_name)
    end

    it 'can create a campaign' do
      admin = create(:admin_user)

      login_as_user(admin.username, admin.password)

      visit admin_campaigns_path

      click_on 'Create New Campaign'

      expect(current_path).to eq(new_admin_campaign_path)

      fill_in :campaign_name, with: 'This Old Campaign'

      click_on 'Create Campaign'

      expect(current_path).to eq(admin_campaigns_path)
      expect(page).to have_content('This Old Campaign')
    end

    it 'can destroy a campaign' do
      campaign = create(:campaign)
      inactive_campaign = create(:inactive_campaign)
      admin = create(:admin_user)
      name = campaign.name

      login_as_user(admin.username, admin.password)

      visit admin_campaigns_path

      expect(page).to have_content(campaign.name)
      expect(page).to have_content(inactive_campaign.name)

      within '#campaign-list' do
        click_on campaign.name
      end
      click_on 'Delete Campaign'

      expect(current_path).to eq(admin_campaigns_path)
      expect(page).to have_content(inactive_campaign.name)
      expect(page).to_not have_content(name)
    end

    it 'can make a campaign as active, making the previous campaign inactive' do
      campaign = create(:campaign)
      inactive_campaign = create(:inactive_campaign)
      admin = create(:admin_user)

      login_as_user(admin.username, admin.password)

      visit admin_campaigns_path

      within("#campaign-#{campaign.id}") do
        expect(page).to_not have_link('Make Active')
      end

      within("#campaign-#{inactive_campaign.id}") do
        click_on 'Make Active'
      end

      expect(current_path).to eq(admin_campaigns_path)

      within("#campaign-#{campaign.id}") do
        expect(page).to have_link('Make Active')
      end

      within("#campaign-#{inactive_campaign.id}") do
        expect(page).to_not have_link('Make Active')
      end
    end
  end

  context 'as a visitor' do
    it 'cannot access campaign management' do
      visit admin_campaigns_path

      expect(current_path).to eq(root_path)
    end
  end

  context 'as a default user' do
    it 'cannot access campaign management' do
      user = create(:user)

      login_as_user(user.username, user.password)

      visit admin_campaigns_path

      expect(current_path).to eq(root_path)
    end
  end
end
