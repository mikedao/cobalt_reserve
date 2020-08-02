require 'rails_helper'

RSpec.describe 'adventure log creation', type: :feature do
  before do
    @campaign = create(:campaign)
    @game_session = GameSession.create(name:      'great session',
                                       campaign:  @campaign)
  end

  context 'as a visitor' do
    context 'when I visit a game session' do
      it 'I cannot create a log for that session but see links to log in' do
        visit game_session_path(@game_session)

        expect(page).not_to have_link('Create New Adventure Log')
        within '#visitor-message' do
          expect(page).to have_link('with a password', href: login_path)
          expect(page).to have_link('using passwordless login',
                                    href: passwordless_login_path)
        end
      end
    end
  end

  context 'as a default user' do
    before do
      user = User.create(username:  'regular user',
                         password:  'password',
                         email:     'user@example.com',
                         role:      0)
      @character = create(:character, campaign: @campaign, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    end

    context 'when I visit a game session I have an active character in' do
      before do
        GameSessionCharacter.create(game_session: @game_session,
                                    character: @character)
      end

      it 'I can create a new adventure log for that session' do
        visit game_session_path(@game_session)

        click_link 'Create New Adventure Log'

        expect(current_path).to eq(new_game_session_adventure_log_path(@game_session))

        fill_in 'Content', with: 'Things happened'
        click_on 'Create Adventure Log'

        expect(current_path).to eq(game_session_path(@game_session))
        within '#adventure-logs' do
          within '.adventure-log:first-of-type' do
            expect(page).to have_content('Things happened')
          end
          within '.adventure-log-citation' do
            expect(page).to have_content "By #{@character.name}"
            expect(page).to have_content(/\d\d\/\d\d\/\d\d, \d\d:\d\d:\d\d [AP]{1}M/)
          end
        end
      end
    end

    context "when I visit a game session I don't have an active character in" do
      it 'I cannot create a log for that session but see message why' do
        visit game_session_path(@game_session)

        expect(page).not_to have_link('Create New Adventure Log')
        expect(page).to have_selector('#non-participating-user-message')
      end
    end
  end
end
