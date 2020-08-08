require 'rails_helper'

RSpec.describe 'Best Adventure Log', type: :feature do
  before do
    @campaign = create(:campaign)
    @game_session = GameSession.create(name:      "Shelob's Lair",
                                       campaign:  @campaign)
    @character_1 = create(:character)
    @character_2 = create(:character)
    @game_session.characters << [@character_1, @character_2]
    @log_1 = create(:adventure_log, character: @character_1, game_session: @game_session)
    @log_2 = create(:adventure_log, character: @character_2, game_session: @game_session)
    @log_3 = create(:adventure_log, character: @character_1, game_session: @game_session)
  end

  context 'as a logged-in admin' do
    before do
      admin = create(:admin_user)
      login_as_user(admin.username, admin.password)
    end

    context 'when I go to a game session show page' do
      before do
        visit game_session_path(@game_session)
      end

      it 'I do not see an adventure log marked as best' do
        expect(page).not_to have_selector '#best-adventure-log'
      end

      it 'I see the logs ordered chronologically by creation' do
        expect(page.body.index(@log_1.content)).to be < page.body.index(@log_2.content)
        expect(page.body.index(@log_2.content)).to be < page.body.index(@log_3.content)
      end

      it 'I see a button next to each adventure log to mark it best' do
        page.all('.adventure-log').each do |log|
          within log do
            expect(page).to have_button 'Mark as Best'
          end
        end
      end

      context 'when I click a Mark as Best button' do
        before do
          within "#adventure-log-#{@log_2.id}" do
            click_on 'Mark as Best'
          end
        end

        it 'I remain on the game session show page' do
          expect(current_path).to eq game_session_path(@game_session)
        end

        it 'I can see the best adventure log moved to top spot with a logo' do
          expect(page).to have_content @log_2.content, count: 1
          expect(page.body.index(@log_2.content)).to be < page.body.index(@log_1.content)
          expect(page.body.index(@log_1.content)).to be < page.body.index(@log_3.content)
          within '#best-adventure-log' do
            expect(page).to have_selector "#adventure-log-#{@log_2.id}"
            expect(page).to have_selector 'img', alt: 'Medal Symbol'
          end
        end

        context 'when I click the button next to another log' do
          before do
            within "#adventure-log-#{@log_3.id}" do
              click_on 'Mark as Best'
            end
          end

          it 'that log is now in the best log spot' do
            within '#best-adventure-log' do
              expect(page).to have_selector "#adventure-log-#{@log_3.id}"
              expect(page).not_to have_selector "#adventure-log-#{@log_2.id}"
            end
          end

          it 'the previous best log is back in reverse chronological order' do
            expect(page.body.index(@log_3.content)).to be < page.body.index(@log_1.content)
            expect(page.body.index(@log_1.content)).to be < page.body.index(@log_2.content)
          end
        end
      end
    end
  end

  context 'as a non-admin logged-in user' do
    before do
      user = create(:user)
      login_as_user(user.username, user.password)
    end

    context 'when I go to a game session show page with a best log marked' do
      before do
        @log_2.best = true
        visit game_session_path(@game_session)
      end

      it 'I do not see the controls to select the best log' do
        expect(page).not_to have_button 'Mark as Best'
      end

      it 'I can see the best adventure log displayed first with a logo' do
        expect(page.body.index(@log_2.content)).to be < page.body.index(@log_1.content)
        expect(page.body.index(@log_1.content)).to be < page.body.index(@log_3.content)
        within '#best-adventure-log' do
          expect(page).to have_selector "#adventure-log-#{@log_2.id}"
          expect(page).to have_selector 'img', alt: 'Medal Symbol'
        end
      end
    end
  end

  context 'as a visitor' do
    context 'when I go to a game session show page with a best log marked' do
      before do
        @log_2.best = true
        visit game_session_path(@game_session)
      end

      it 'I do not see the controls to select the best log' do
        expect(page).not_to have_button 'Mark as Best'
      end

      it 'I can see the best adventure log displayed first with a logo' do
        expect(page.body.index(@log_2.content)).to be < page.body.index(@log_1.content)
        expect(page.body.index(@log_1.content)).to be < page.body.index(@log_3.content)
        within '#best-adventure-log' do
          expect(page).to have_selector "#adventure-log-#{@log_2.id}"
          expect(page).to have_selector 'img', alt: 'Medal Symbol'
        end
      end
    end
  end
end