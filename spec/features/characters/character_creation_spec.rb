require 'rails_helper'

RSpec.feature 'Character creation' do
  before :each do
    @campaign = create(:campaign, status: 'active')
    @user = create(:user)
  end

  describe 'happy path' do
    before :each do
      visit root_path
      click_link 'Log In'
      fill_in :username, with: @user.username
      fill_in :password, with: @user.password
      click_button 'Log In'
      expect(current_path).to eq(profile_path)
    end

    describe 'when a user is logged in' do
      it 'allows creation of a campaign character' do
        expect(page).to have_button('Create Character')
        click_button 'Create Character'

        expect(current_path).to eq(new_user_character_path(@user))

        fill_in :character_name, with: 'Cormyn'
        select 'Human', from: :character_species
        select 'Hunter', from: :character_character_class
        fill_in :character_level, with: 4
        click_button 'Create Character'

        # db lookup for expectations below
        ch = Character.last

        expect(current_path).to eq(profile_path)
        within "#char-#{ch.id}" do
          expect(page).to have_content(ch.name)
          expect(page).to have_content("#{ch.species} #{ch.character_class}")
          expect(page).to have_content("Level: #{ch.level}")
          expect(page).to have_content('Active: false')
        end
      end

      it 'should block creation from starting if no campaign is active' do
        @campaign.update!(status: 'inactive')
        # reload profile path
        visit profile_path

        expect(page).to_not have_button('Create Character')
      end
      it 'should block creation from starting if no campaign exists' do
        @campaign.delete
        # reload profile path
        visit profile_path

        expect(page).to_not have_button('Create Character')
      end
    end
  end

  describe 'sad path' do
    before :each do
      visit root_path
      click_link 'Log In'
      fill_in :username, with: @user.username
      fill_in :password, with: @user.password
      click_button 'Log In'
      expect(current_path).to eq(profile_path)
    end

    it 'fails when user is missing required data on the form' do
      expect(page).to have_button('Create Character')
      click_button 'Create Character'

      expect(current_path).to eq(new_user_character_path(@user))
      # fill in no data
      click_button 'Create Character'

      expect(current_path).to eq(user_characters_path(@user))
      expect(page).to have_content('6 errors prohibited this character from being saved')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content("Level can't be blank")
      expect(page).to have_content("Character class can't be blank")
      expect(page).to have_content('Character class is too short (minimum is 4 characters)')
      expect(page).to have_content("Species can't be blank")
      expect(page).to have_content('Species is too short (minimum is 4 characters)')
    end

    it 'fails when campaign is made inactive during the character creation' do
      expect(page).to have_button('Create Character')
      click_button 'Create Character'

      expect(current_path).to eq(new_user_character_path(@user))

      # while on this page, the campaign is made inactive
      @campaign.update!(status: 'inactive')

      fill_in :character_name, with: 'Cormyn'
      select 'Human', from: :character_species
      select 'Hunter', from: :character_character_class
      fill_in :character_level, with: 4
      click_button 'Create Character'

      expect(current_path).to eq(user_characters_path(@user))
      expect(page).to have_content('Sorry, there is no active campaign.')
    end

    it 'fails when campaign is deleted during the character creation' do
      expect(page).to have_button('Create Character')
      click_button 'Create Character'

      expect(current_path).to eq(new_user_character_path(@user))

      # while on this page, the campaign is deleted outright
      @campaign.delete

      fill_in :character_name, with: 'Cormyn'
      select 'Human', from: :character_species
      select 'Hunter', from: :character_character_class
      fill_in :character_level, with: 4
      click_button 'Create Character'

      expect(current_path).to eq(user_characters_path(@user))
      expect(page).to have_content('Sorry, there is no active campaign.')
    end
  end
end