require 'rails_helper'
RSpec.describe 'Admin edits foundry keys', type: :feature do
  context 'as an admin' do
    it 'can edit a character foundry key' do
      campaign = create(:campaign)
      user = create(:user)
      admin = create(:admin_user)
      character = create(:character, campaign: campaign, user: user)
      character_2 = create(:character, campaign: campaign, user: user)

      login_as_user(admin.username, admin.password)
      visit admin_dashboard_path

      click_link 'Foundry Key Management'

      expect(current_path).to eq(admin_foundry_key_path)
      expect(page).to have_content(character.name)
      expect(page).to have_content(character.foundry_key)
      expect(page).to have_content(character_2.name)
      expect(page).to have_content(character_2.foundry_key)

      click_on character.name

      expect(current_path).to eq(admin_edit_foundry_key_path(character))
      old_key = character.foundry_key

      fill_in :character_foundry_key, with: 'new_key_here'
      click_on 'Update Foundry Key'

      expect(current_path).to eq(admin_foundry_key_path)
      expect(page).to have_content('new_key_here')
      expect(page).to_not have_content(old_key)
    end
  end

  context 'as a user' do
    it 'cannot access foundry key management' do
      campaign = create(:campaign)
      user = create(:user)
      admin = create(:admin_user)
      character = create(:character, campaign: campaign, user: user)
      character_2 = create(:character, campaign: campaign, user: user)

      login_as_user(user.username, user.password)

      visit admin_foundry_key_path

      expect(current_path).to eq(root_path)
    end
  end

  context 'as a visitor' do
    it 'cannot access foundry key management' do
      campaign = create(:campaign)
      user = create(:user)
      admin = create(:admin_user)
      create(:character, campaign: campaign, user: user)
      create(:character, campaign: campaign, user: user)

      visit admin_foundry_key_path

      expect(current_path).to eq(root_path)
    end
  end
end
