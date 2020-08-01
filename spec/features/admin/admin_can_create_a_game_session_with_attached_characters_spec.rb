require 'rails_helper'

RSpec.describe 'admin dashboard index', type: :feature do
  context 'as an admin' do
    context 'I can click create session in the dashboard' do
      it 'lets me create a session' do
        campaign = create(:campaign)
        char1 = create(:character, campaign: campaign)
        char2 = create(:character, campaign: campaign)
        char3 = create(:character, campaign: campaign)
        char4 = create(:inactive_character, campaign: campaign)
        user = create(:admin_user)

        login_as_user(user.username, user.password)
        visit admin_dashboard_path

        click_on 'Create Session'

        expect(current_path).to eq(admin_game_sessions_new_path)
        expect(page).to have_content(char1.name)
        expect(page).to have_content(char2.name)
        expect(page).to have_content(char3.name)
        expect(page).not_to have_content(char4.name)

        fill_in 'Name', with: 'Super Great Fun'
        check char1.name
        check char3.name
        click_on 'Create Game Session'

        expect(page).to have_content('Super Great Fun')
        expect(page).to have_content(char1.name)
        expect(page).to have_content(char3.name)
        expect(page).to_not have_content(char2.name)
        expect(page).to have_content(Date.today)
      end

      it 'does not let me add an inactive character to a session' do
        campaign = create(:campaign)
        char1 = create(:character, campaign: campaign)
        char2 = create(:character, campaign: campaign)
        char3 = create(:character, campaign: campaign)
        char4 = create(:character, campaign: campaign, active: false)
        user = create(:admin_user)

        login_as_user(user.username, user.password)
        visit admin_dashboard_path

        click_on 'Create Session'

        expect(current_path).to eq(admin_game_sessions_new_path)

        expect(page).to_not have_content(char4.name)
      end
    end
  end
end
