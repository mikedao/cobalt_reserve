require 'rails_helper'

RSpec.describe 'admin dashboard index', type: :feature do
  context 'as an admin' do
    context 'I can click create session in the dashboard' do
      before do
        campaign = create(:campaign)
        @char1 = create(:character, campaign: campaign)
        @char2 = create(:character, campaign: campaign)
        @char3 = create(:character, campaign: campaign)
        @char4 = create(:inactive_character, campaign: campaign)
        user = create(:admin_user)

        login_as_user(user.username, user.password)
      end

      it 'lets me create a session' do
        visit admin_dashboard_path

        click_on 'Create Game Session'

        expect(current_path).to eq(admin_game_sessions_new_path)
        expect(page).to have_content(@char1.name)
        expect(page).to have_content(@char2.name)
        expect(page).to have_content(@char3.name)
        expect(page).not_to have_content(@char4.name)

        fill_in 'Name', with: 'Super Great Fun'
        check @char1.name
        check @char3.name
        click_on 'Create Game Session'

        expect(page).to have_content 'Your game session was created.'
        expect(page).to have_content('Super Great Fun')
        expect(page).to have_content(@char1.name)
        expect(page).to have_content(@char3.name)
        expect(page).to_not have_content(@char2.name)
        expect(page).to have_content(Date.today)
      end

      it 'does not let me add an inactive character to a session' do
        visit admin_dashboard_path

        click_on 'Create Game Session'

        expect(current_path).to eq(admin_game_sessions_new_path)
        expect(page).to_not have_content(@char4.name)
      end

      it 'shows me an error message if no characters selected' do
        visit admin_dashboard_path

        click_on 'Create Game Session'
        fill_in 'Name', with: 'There and Back Again'
        click_on 'Create Game Session'

        expect(current_path).to eq(admin_game_sessions_new_path)
        expect(page).to have_content 'You must select at least one character.'
      end

      it 'does not allow me to submit if no name is entered' do
        visit admin_dashboard_path

        click_on 'Create Game Session'
        check @char1.name
        click_on 'Create Game Session'

        expect(current_path).to eq(admin_game_sessions_new_path)
        expect(page).to have_content "Name can't be blank"
      end
    end
  end
end
