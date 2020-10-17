require 'rails_helper'

RSpec.feature 'Character updating' do
  before :each do
    @campaign = create(:campaign, status: 'active')
    @user = create(:user)
    @character = create(:character, user: @user, campaign: @campaign, active: true)
    @user2 = create(:user)
    @character2 = create(:character, user: @user2, campaign: @campaign, name: 'Not Cormyn', active: true)
    @species = Culture.order(:name)
  end

  describe 'happy path' do
    before :each do
      login_as_user(@user.username, @user.password)
      visit profile_path
    end

    it 'allows a user to update a character' do
      within "#char-#{@character.id}" do
        expect(page).to have_content('Active Campaign Character')
        click_button 'Edit Character'
      end

      expect(page).to have_select 'Ancestry 1', selected: @character.ancestryone.name
      expect(page).to have_select 'Ancestry 2', selected: @character.ancestrytwo.name
      expect(page).to have_select 'Culture', selected: @character.culture.name
      expect(page).to have_select 'Class', selected: @character.klass, options: Character.classes

      fill_in :character_name, with: 'Cormyn'
      select 'Human', from: :character_ancestryone_id
      select 'Gnome', from: :character_ancestrytwo_id
      select 'Elf', from: :character_culture_id
      select 'Hunter', from: :character_klass
      fill_in :character_level, with: 4
      click_button 'Update Character'

      # db lookup for expectations below
      ch = Character.find(@character.id)

      expect(current_path).to eq(profile_path)
      within "#char-#{ch.id}" do
        within '.card-header' do
          expect(page).to have_link(ch.name)
          expect(page).to have_content("Level #{ch.level} #{ch.klass}")
          expect(page).to have_content("Active Campaign Character")
        end
        within '.ancestry' do
          expect(page).to have_content(ch.build_ancestry)
        end
        within '.culture' do
          expect(page).to have_content(ch.culture.name)
        end
      end
    end

    describe 'allows a user to toggle the active state on a character' do
      it 'allows the user to make an inactive character active, making all other characters inactive' do
        ch2 = create(:character, user: @user, campaign: @campaign, active: false)
        visit profile_path

        within "#char-#{@character.id}" do
          expect(page).to have_content('Active Campaign Character')
          expect(page).to_not have_button 'Make Active!'
        end

        within "#char-#{ch2.id}" do
          click_button 'Make Active!'
        end

        expect(current_path).to eq(profile_path)
        expect(page).to have_content("#{ch2.name} is now active!")

        within "#char-#{@character.id}" do
          expect(page).to have_button 'Make Active!'
        end

        within "#char-#{ch2.id}" do
          expect(page).to have_content('Active Campaign Character')
          expect(page).to_not have_button 'Make Active!'
        end
      end

      it 'blocks users from activating a character belonging to another player' do
        page.driver.put user_activate_character_path(@user, @character2)
        visit profile_path
        expect(page).to have_content('The character you tried to activate is invalid')
      end
    end

    it 'could allow a user to update a character from character index page too' do
      visit characters_path

      within "#char-#{@character.id}" do
        expect(page).to have_content('Active Campaign Character')
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
      select '(None)', from: :character_ancestrytwo_id
      fill_in :character_level, with: ''
      fill_in :character_dndbeyond_url, with: ''
      click_button 'Update Character'

      expect(current_path).to eq(user_character_path(@user, @character))
      expect(page).to have_content('5 errors prohibited this character from being saved')
      expect(page).to have_content('Your character level must be set')
      expect(page).to have_content('Your character level must be a number between 1 and 20')
      expect(page).to have_content("Name can't be blank")
      expect(page).to have_content('Name is too short, please enter at least 2 characters')
      expect(page).to have_content('Your DND Beyond Character Sheet must be provided')
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
