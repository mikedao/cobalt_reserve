require 'rails_helper'

RSpec.describe 'character show', type: :feature do
  describe 'happy path' do
    context 'as a visitor' do
      context 'when I visit /characters/:id' do
        it "I see the character's attributes" do
          @character = create(:character)

          visit character_path(@character)

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
      end
    end
  end
end
