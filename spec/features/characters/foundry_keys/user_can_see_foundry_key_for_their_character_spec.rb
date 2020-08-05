require 'rails_helper'

RSpec.describe 'Foundry Key', type: :feature do
  context 'as a user' do
    it 'can display a characters foundry key on their show page' do
      campaign = create(:campaign)
      user = create(:user)
      character = create(:character, campaign: campaign, user: user)

      login_as_user(user.username, user.password)

      visit character_path(character)

      expect(page).to have_content(character.foundry_key)
    end

    it 'cannot display another characters foundry_key' do
      campaign = create(:campaign)
      user = create(:user)
      character = create(:character, campaign: campaign, user: user)
      user_2 = create(:user)

      login_as_user(user_2.username, user_2.password)
      visit character_path(character)

      expect(page).to_not have_content(character.foundry_key)
    end
  end

  context 'as an admin user' do
    it 'can display a characters foundry key on their show page' do
      campaign = create(:campaign)
      admin = create(:admin_user)
      user = create(:user)
      character = create(:character, campaign: campaign, user: user)

      login_as_user(admin.username, admin.password)
      visit character_path(character)

      expect(page).to have_content(character.foundry_key)
    end
  end

  context 'as a visitor' do
    it 'cannot see a characters foundry key on their show page' do
      campaign = create(:campaign)
      user = create(:user)
      character = create(:character, campaign: campaign, user: user)

      visit character_path(character)

      expect(page).to_not have_content(character.foundry_key)
    end
  end
end
