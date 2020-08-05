require 'rails_helper'

RSpec.describe 'Game Session Show has links to Character Show', type: :feature do
  context 'as a visitor' do
    it 'has links to character show pages on the game session show page' do
      campaign = create(:campaign)
      user = create(:user)
      character_1 = create(:character, user: user, campaign: campaign)
      character_2 = create(:character, user: user, campaign: campaign)
      game_session = create(:game_session)

      game_session.characters << character_1
      game_session.characters << character_2

      visit game_session_path(game_session)

      click_link character_1.name

      expect(current_path).to eq(character_path(character_1))

      visit game_session_path(game_session)

      click_link character_2.name

      expect(current_path).to eq(character_path(character_2))
    end
  end
end
