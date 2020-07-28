require 'rails_helper'

RSpec.describe 'admin dashboard index', type: :feature do
  context 'as an admin' do
    context 'I can click create session in the dashboard' do
      it 'lets me create a session' do
        campaign = create(:campaign)
        char1 = create(:character, campaign: campaign)
        char2 = create(:character, campaign: campaign)
        char3 = create(:character, campaign: campaign)
        user = User.create(username: 'admin',
                           password: 'adminpass',
                           email:    'admin@example.com',
                           role:     1)

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit admin_dashboard_path

        click_on 'Create Session'

        expect(current_path).to eq('/admin/game_sessions/new')

        fill_in 'Name', with: 'Super Great Fun'
        check "game_session_characters_#{char1.id}"
        check "game_session_characters_#{char3.id}"
        click_on 'Create Game Session'

        expect(page).to have_content('Super Great Fun')
        expect(page).to have_content(char1.name)
        expect(page).to have_content(char3.name)
        expect(page).to_not have_content(char2.name)
      end
    end
  end
end
