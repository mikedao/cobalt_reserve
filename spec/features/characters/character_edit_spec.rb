require 'rails_helper'

RSpec.feature 'Character updating' do
  before :each do
    campaign = create(:campaign, status: 'active')
    @user = create(:user)
    @character = create(:character, user: @user, campaign: campaign, active: true)
    @user2 = create(:user)
    @character2 = create(:character, user: @user2, campaign: campaign, name: 'Not Cormyn', active: true)
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

      expect(page).to have_select 'Species', selected: @character.species, options: Character.species
      expect(page).to have_select 'Class', selected: @character.character_class, options: Character.classes

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
    it 'could allow a user to update a character from character index page too' do
      visit characters_path

      within "#char-#{@character.id}" do
        expect(page).to have_content('Active: true')
        expect(page).to have_button 'Edit Character'
      end

      within "#char-#{@character2.id}" do
        expect(page).to have_content(@character2.name)
        expect(page).to_not have_button 'Edit Character'
      end
    end
  end

  describe 'sad path' do
    before :each do
      login_as_user(@user.username, @user.password)
      visit profile_path
    end

    it 'does not succeed if required data is now missing' do
      visit edit_user_character_path(@user, @character)

      fill_in :character_name, with: ''
      select '', from: :character_species
      select '', from: :character_character_class
      fill_in :character_level, with: ''
      fill_in :character_dndbeyond_url, with: ''
      click_button 'Update Character'

      expect(current_path).to eq(user_character_path(@user, @character))
      expect(page).to have_content('9 errors prohibited this character from being saved')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('Name is too short (minimum is 2 characters)')
      expect(page).to have_content("Dndbeyond url can't be blank")
      expect(page).to have_content("Level can't be blank")
      expect(page).to have_content('Level is not a number')
      expect(page).to have_content("Character class can't be blank")
      expect(page).to have_content('Character class is too short (minimum is 4 characters)')
      expect(page).to have_content("Species can't be blank")
      expect(page).to have_content('Species is too short (minimum is 3 characters)')
    end

    it 'does not succeed if a user tries to edit a character that is not theirs' do
      visit edit_user_character_path(@user, @character2)

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('The character you tried to edit is invalid')
    end

    it 'does not succeed if a user tries REALLY HARD to edit a character that is not theirs' do
      page.driver.put user_character_path(@user, @character2), { 'name': 'Cormyn Hacked You' }
      visit profile_path

      expect(page).to have_content('The character you tried to edit is invalid')

      visit characters_path
      within "#char-#{@character2.id}" do
        expect(page).to_not have_content('Cormyn Hacked You')
      end
    end
  end
end