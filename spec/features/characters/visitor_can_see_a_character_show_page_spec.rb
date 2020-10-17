require 'rails_helper'

RSpec.describe 'character show', type: :feature do
  describe 'happy path' do
    context 'as a visitor' do
      context 'when I visit /characters/:id' do
        before do
          @character = create(:character)

          visit character_path(@character)
        end

        it "I see the character's attributes" do
          within "#char-#{@character.id}" do
            within '.card-header' do
              expect(page).to have_link(@character.name)
              expect(page).to have_content("Level #{@character.level} #{@character.klass}")
              expect(page).to have_content("Active Campaign Character")
            end

            within '.ancestry' do
              expect(page).to have_content(@character.build_ancestry)
            end
          end

          expect(page).to have_link('D&D Beyond Character Sheet')
        end

        it 'I can see how many best logs the character has had' do
          campaign = create(:campaign)
          character_1 = create(:character, campaign: campaign)
          character_2 = create(:character, campaign: campaign)
          character_3 = create(:character, campaign: campaign)
          game_session_1 = create(:game_session, campaign: campaign)
          game_session_1.characters << [character_1, character_2, character_3]
          game_session_2 = create(:game_session, campaign: campaign)
          game_session_2.characters << [character_1, character_2, character_3]
          game_session_3 = create(:game_session, campaign: campaign)
          game_session_3.characters << [character_1, character_2, character_3]
          create(:adventure_log, character: character_1, game_session: game_session_1, best: true)
          create(:adventure_log, character: character_2, game_session: game_session_1)
          create(:adventure_log, character: character_3, game_session: game_session_1)
          create(:adventure_log, character: character_1, game_session: game_session_2)
          create(:adventure_log, character: character_2, game_session: game_session_2)
          create(:adventure_log, character: character_3, game_session: game_session_2, best: true)
          create(:adventure_log, character: character_1, game_session: game_session_3, best: true)
          create(:adventure_log, character: character_2, game_session: game_session_3)
          create(:adventure_log, character: character_3, game_session: game_session_3)

          visit character_path(character_1)

          expect(page).to have_content 'Times Awarded Best Adventure Log: 2'

          visit character_path(character_2)

          expect(page).to have_content 'Times Awarded Best Adventure Log: 0'

          visit character_path(character_3)

          expect(page).to have_content 'Times Awarded Best Adventure Log: 1'
        end
      end
    end
  end
end
