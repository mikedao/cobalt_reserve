require 'rails_helper'

RSpec.feature 'Character creation' do
  before :each do
    @campaign = create(:campaign, status: 'active')
    @user = create(:user)
  end

  describe 'happy path' do
    before :each do
      login_as_user(@user.username, @user.password)
      visit profile_path
      expect(current_path).to eq(profile_path)
    end

    describe 'when a user is logged in' do
      it 'allows creation of a campaign character' do
        expect(page).to have_button('Create Character')
        click_button 'Create Character'

        expect(current_path).to eq(new_user_character_path(@user))

        fill_in :character_name, with: 'Cormyn'
        select 'Human', from: :character_ancestryone_id
        select 'Gnome', from: :character_ancestrytwo_id
        select 'Elf', from: :character_culture_id
        select 'Hunter', from: :character_klass
        fill_in :character_level, with: 4
        fill_in :character_dndbeyond_url, with: 'http://dndbeyond.com/1234'
        click_button 'Create Character'

        # db lookup for expectations below
        ch = Character.last

        expect(current_path).to eq(profile_path)
        within "#char-#{ch.id}" do
          expect(page).to have_content('Cormyn')
          expect(page).to have_content(ch.name)
          within '.ancestry' do
            expect(page).to have_content(ch.build_ancestry)
          end
          within '.klass' do
            expect(page).to have_content(ch.klass)
          end
          expect(page).to have_content("Level: #{ch.level}")
          expect(page).to have_content('Active: true')
        end
      end

      it 'should allow them to make a new inactive character if one already exists for this campaign' do
        ch1 = create(:character, user: @user, campaign: @campaign)
        visit new_user_character_path(@user)

        fill_in :character_name, with: 'Cormyn'
        select 'Human', from: :character_ancestryone_id
        select 'Gnome', from: :character_ancestrytwo_id
        select 'Elf', from: :character_culture_id
        select 'Hunter', from: :character_klass
        fill_in :character_level, with: 4
        fill_in :character_dndbeyond_url, with: 'http://dndbeyond.com/1234'
        click_button 'Create Character'

        # db lookup for expectations below
        ch2 = Character.last

        expect(current_path).to eq(profile_path)
        within "#char-#{ch1.id}" do
          expect(page).to have_content(ch1.name)
          expect(page).to have_content('Active: true')
        end

        within "#char-#{ch2.id}" do
          expect(page).to have_content(ch2.name)
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
      login_as_user(@user.username, @user.password)
      visit profile_path
      expect(current_path).to eq(profile_path)
    end

    it 'fails when user is missing required data on the form' do
      expect(page).to have_button('Create Character')
      click_button 'Create Character'

      expect(current_path).to eq(new_user_character_path(@user))
      # fill in no data
      click_button 'Create Character'

      expect(current_path).to eq(user_characters_path(@user))
      expect(page).to have_content('8 errors prohibited this character from being saved')
      expect(page).to have_content('Your first ancestry must be chosen')
      expect(page).to have_content('Your cultural background must be chosen')
      expect(page).to have_content('Your character level must be a number between 1 and 20')
      expect(page).to have_content('Your character level must be set')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('Name is too short, please enter at least 2 characters')
      expect(page).to have_content('Your DND Beyond Character Sheet must be provided')
      expect(page).to have_content('Your class must be chosen')
    end

    it 'fails when campaign is made inactive during the character creation' do
      expect(page).to have_button('Create Character')
      click_button 'Create Character'

      expect(current_path).to eq(new_user_character_path(@user))

      # while on this page, the campaign is made inactive
      @campaign.update!(status: 'inactive')

      fill_in :character_name, with: 'Cormyn'
      select 'Human', from: :character_ancestryone_id
      select 'Gnome', from: :character_ancestrytwo_id
      select 'Elf', from: :character_culture_id
      select 'Hunter', from: :character_klass
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
      select 'Human', from: :character_ancestryone_id
      select 'Gnome', from: :character_ancestrytwo_id
      select 'Elf', from: :character_culture_id
      select 'Hunter', from: :character_klass
      fill_in :character_level, with: 4
      click_button 'Create Character'

      expect(current_path).to eq(user_characters_path(@user))
      expect(page).to have_content('Sorry, there is no active campaign.')
    end
  end
end