require 'rails_helper'

RSpec.describe 'Best Adventure Log', type: :feature do
  before do
    @campaign = create(:campaign)
    @game_session = create(:game_session, campaign: @campaign)
    @character_1 = create(:character)
    @character_2 = create(:character)
    @game_session.characters << [@character_1, @character_2]
    @log_1 = create(:adventure_log, character: @character_1, game_session: @game_session, created_at: Date.today)
    @log_2 = create(:adventure_log, character: @character_2, game_session: @game_session, created_at: Date.today + 1)
    @log_3 = create(:adventure_log, character: @character_1, game_session: @game_session, created_at: Date.today + 2)
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
        expect(page.body.index(section_name(@log_1))).to be < page.body.index(section_name(@log_2))
        expect(page.body.index(section_name(@log_2))).to be < page.body.index(section_name(@log_3))
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
          find(section_id(@log_2)).click_on 'Mark as Best'
        end

        it 'I remain on the game session show page' do
          expect(current_path).to eq game_session_path(@game_session)
        end

        it 'I can see the best adventure log moved to top spot with a logo' do
          expect(page).to have_content @log_2.content, count: 1
          expect(page.body.index(section_name(@log_2))).to be < page.body.index(section_name(@log_1))
          expect(page.body.index(section_name(@log_1))).to be < page.body.index(section_name(@log_3))
          within '#best-adventure-log' do
            expect(page).to have_selector section_id(@log_2)
            expect(page).to have_selector 'img[@alt="Medal Symbol"]'
          end
        end

        it 'I see the button text next to the best log changed' do
          within section_id(@log_2) do
            expect(page).to have_button 'Unmark as Best'
            expect(page).not_to have_button 'Mark as Best'
          end
        end

        context 'when I click the button to unmark as best' do
          before do
            find('#best-adventure-log').click_on 'Unmark as Best'
          end

          it 'I remain on the game session show page' do
            expect(current_path).to eq game_session_path(@game_session)
          end

          it 'the page no longer has a best adventure log designated' do
            expect(page).not_to have_selector '#best-adventure-log'
          end

          it 'the adventure logs return to being ordered chronologically' do
            expect(page.body.index(section_name(@log_1))).to be < page.body.index(section_name(@log_2))
            expect(page.body.index(section_name(@log_2))).to be < page.body.index(section_name(@log_3))
          end

          it 'the button text changes back to mark as best' do
            within section_id(@log_2) do
              expect(page).not_to have_button 'Unmark as Best'
              expect(page).to have_button 'Mark as Best'
            end
          end
        end

        context 'when I click the button next to another log' do
          before do
            find(section_id(@log_3)).click_on 'Mark as Best'
          end

          it 'that log is now in the best log spot' do
            within '#best-adventure-log' do
              expect(page).to have_selector section_id(@log_3)
              expect(page).not_to have_selector section_id(@log_2)
            end
          end

          it 'the previous best log is back in chronological order' do
            expect(page.body.index(section_name(@log_3))).to be < page.body.index(section_name(@log_1))
            expect(page.body.index(section_name(@log_1))).to be < page.body.index(section_name(@log_2))
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
        AdventureLog.find(@log_2.id).update(best: true)
        visit game_session_path(@game_session)
      end

      it 'I do not see the controls to select the best log' do
        expect(page).not_to have_button 'Mark as Best'
      end

      it 'I can see the best adventure log displayed first with a logo' do
        expect(page.body.index(section_name(@log_2))).to be < page.body.index(section_name(@log_1))
        expect(page.body.index(section_name(@log_1))).to be < page.body.index(section_name(@log_3))
        within '#best-adventure-log' do
          expect(page).to have_selector section_id(@log_2)
          expect(page).to have_selector 'img[@alt="Medal Symbol"]'
        end
      end
    end
  end

  context 'as a visitor' do
    context 'when I go to a game session show page with a best log marked' do
      before do
        AdventureLog.find(@log_2.id).update!(best: true)
        visit game_session_path(@game_session)
      end

      it 'I do not see the controls to select the best log' do
        expect(page).not_to have_button 'Mark as Best'
      end

      it 'I can see the best adventure log displayed first with a logo' do
        expect(page.body.index(section_name(@log_2))).to be < page.body.index(section_name(@log_1))
        expect(page.body.index(section_name(@log_1))).to be < page.body.index(section_name(@log_3))
        within '#best-adventure-log' do
          expect(page).to have_selector section_id(@log_2)
          expect(page).to have_selector 'img[@alt="Medal Symbol"]'
        end
      end
    end
  end
end

def section_name(log)
  "adventure-log-#{log.id}"
end

def section_id(log)
  '#' + section_name(log)
end