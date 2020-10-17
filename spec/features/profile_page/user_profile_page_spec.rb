require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  context 'when I log in on the front page' do
    before :each do
      @user = create(:user)
    end

    it 'redirects me to my profile page and I can see my characters' do
      @active_campaign = create(:campaign)
      @old_campaign = create(:campaign, status: 'inactive')
      @user_2 = create(:user)

      @character_1 = create(:character, user: @user, campaign: @active_campaign)               # expected
      @character_2 = create(:character, user: @user, campaign: @old_campaign)                  # expected
      @character_3 = create(:character, user: @user, campaign: @old_campaign, active: false)   # expected
      @character_4 = create(:character, user: @user_2, campaign: @old_campaign)                # not expected

      login_as_user(@user.username, @user.password)
      visit profile_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content(@active_campaign.name)

      within "#char-#{@character_1.id}" do
        within '.card-header' do
          expect(page).to have_link(@character_1.name)
          expect(page).to have_content("Level #{@character_1.level} #{@character_1.klass}")
          expect(page).to have_content('Active Campaign Character')
          expect(page).to_not have_button('Make Active!')
        end
        within '.ancestry' do
          expect(page).to have_content(@character_1.build_ancestry)
        end
      end

      within "#char-#{@character_2.id}" do
        within '.card-header' do
          expect(page).to have_link(@character_2.name)
          expect(page).to have_content("Level #{@character_2.level} #{@character_2.klass}")
          expect(page).to have_content('Active Campaign Character')
          expect(page).to_not have_button('Make Active!')
        end
        within '.ancestry' do
          expect(page).to have_content(@character_2.build_ancestry)
        end
      end

      within "#char-#{@character_3.id}" do
        expect(page).to have_link(@character_3.name)
        expect(page).to have_content("Level #{@character_3.level} #{@character_3.klass}")
        expect(page).to_not have_content('Active Campaign Character')
        expect(page).to have_button('Make Active!')
        within '.ancestry' do
          expect(page).to have_content(@character_3.build_ancestry)
        end
      end

      expect(page).to_not have_content(@character_4.name)

      expect(page).to have_css('.card-body', count: 3)
    end

    it 'should show clearly that no active campaign is present if there is none' do
      login_as_user(@user.username, @user.password)
      visit profile_path

      expect(current_path).to eq(profile_path)
      expect(page).to have_content('Current Campaign: (None Active)')
    end
  end
end
