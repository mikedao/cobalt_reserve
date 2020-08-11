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
            expect(page).to have_content(@character.name)

            within '.ancestry' do
              expect(page).to have_content(@character.build_ancestry)
            end

            within '.klass' do
              expect(page).to have_content("Class: #{@character.klass}")
            end

            expect(page).to have_content("Level: #{@character.level}")
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
          log_1 = create(:adventure_log, character: character_1, game_session: game_session_1, best: true)
          log_2 = create(:adventure_log, character: character_2, game_session: game_session_1)
          log_3 = create(:adventure_log, character: character_3, game_session: game_session_1)
          log_4 = create(:adventure_log, character: character_1, game_session: game_session_2)
          log_5 = create(:adventure_log, character: character_2, game_session: game_session_2)
          log_6 = create(:adventure_log, character: character_3, game_session: game_session_2, best: true)
          log_7 = create(:adventure_log, character: character_1, game_session: game_session_3, best: true)
          log_8 = create(:adventure_log, character: character_2, game_session: game_session_3)
          log_9 = create(:adventure_log, character: character_3, game_session: game_session_3)

          visit character_path(character_1)

          expect(page).to have_content 'Adventure Logs Marked Best: 2'

          visit character_path(character_2)

          expect(page).to have_content 'Adventure Logs Marked Best: 0'

          visit character_path(character_3)

          expect(page).to have_content 'Adventure Logs Marked Best: 1'
        end
      end
    end
  end
end
