require 'rails_helper'

RSpec.feature 'Character updating' do
  before :each do
    @campaign = create(:campaign, status: 'active')
    @user = create(:user)
    @character = create(:character, user: @user, campaign: @campaign)
  end

  describe 'happy path' do
    before :each do
      login_as_user(@user.username, @user.password)
      visit profile_path
    end
    it 'allows a user to update a character' do
      within "#char-#{@character.id}" do
        expect(page).to have_content('Active: true')
        click_button 'Edit Character'
      end

      fill_in :character_name, with: 'Cormyn'
      select 'Human', from: :character_species
      select 'Hunter', from: :character_character_class
      fill_in :character_level, with: 4
      click_button 'Update Character'

      # db lookup for expectations below
      ch = Character.find(@character.id)

      expect(current_path).to eq(profile_path)
      within "#char-#{ch.id}" do
        expect(page).to have_content(ch.name)
        expect(page).to have_content("#{ch.species} #{ch.character_class}")
        expect(page).to have_content("Level: #{ch.level}")
        expect(page).to have_content('Active: true')
      end
    end
  end
end