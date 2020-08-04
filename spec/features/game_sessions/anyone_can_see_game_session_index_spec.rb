require 'rails_helper'

RSpec.describe "game session index", type: :feature do
  before do
    campaign = create(:campaign)
    @game_session_1 = create(:game_session, campaign: campaign)
    @game_session_2 = create(:game_session, campaign: campaign)
    @game_session_3 = create(:game_session, campaign: campaign)
  end

  context 'as a visitor' do
    it 'I see a link on the homepage which takes me to game session index' do
      validate_game_session_index
    end

    it 'I can click the name of a game session to go to its show page' do
      visit '/game_sessions'

      click_on @game_session_1.name

      expect(current_path).to eq game_session_path(@game_session_1)
      expect(page).to have_content @game_session_1.name
    end
  end

  context 'as a logged-in standard user' do
    it 'I see a link on the homepage which takes me to game session index' do
      validate_game_session_index
    end
  end

  context 'as a logged-in admin user' do
    it 'I see a link on the homepage which takes me to game session index' do
      validate_game_session_index
    end
  end
end

def validate_game_session_index
  visit '/'

  click_link 'Game Session Index'

  expect(current_path).to eq '/game_sessions'
  expect(page).to have_link @game_session_1.name, href: game_session_path(@game_session_1)
  expect(page).to have_link @game_session_2.name, href: game_session_path(@game_session_2)
  expect(page).to have_link @game_session_3.name, href: game_session_path(@game_session_3)
end