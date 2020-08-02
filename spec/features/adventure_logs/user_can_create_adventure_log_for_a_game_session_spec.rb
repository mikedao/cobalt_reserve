require 'rails_helper'

RSpec.describe 'adventure log creation', type: :feature do
  context 'as a default user' do
    context 'when I visit a game session' do
      it 'I can create a new adventure log for that session' do
        campaign = create(:campaign)
        user = User.create(username:  'regular user',
                           password:  'password',
                           email:     'user@example.com',
                           role:      0)
        character = create(:character, campaign: campaign, user: user)
        game_session = GameSession.create(name:      'great session',
                                          campaign:  campaign)
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

        visit game_session_path(game_session)

        click_link 'Create New Adventure Log'

        expect(current_path).to eq(new_game_session_adventure_log_path(game_session))

        fill_in 'Content', with: 'Things happened'
        click_on 'Create Adventure Log'

        expect(current_path).to eq(game_session_path(game_session))
        within '#adventure-logs' do
          within '.adventure-log:first-of-type' do
            expect(page).to have_content('Things happened')
          end
          within '.adventure-log-citation' do
            expect(page).to have_content "By #{character.name}"
            expect(page).to have_content(/\d\d\/\d\d\/\d\d, \d\d:\d\d:\d\d [AP]{1}M/)
          end
        end
      end
    end
  end
end
