require 'rails_helper'

RSpec.describe 'character show', type: :feature do
  describe 'happy path' do
    context 'as a visitor' do
      context 'when I visit /characters/:id' do
        it "I see the character's attributes" do
          @character = create(:character)

          visit character_path(@character)

          expect(page).to have_content(@character.name)
          expect(page).to have_content(@character.species)
          expect(page).to have_content(@character.character_class)
          expect(page).to have_content(@character.level)
          expect(page).to have_content('D&D Beyond')
        end
      end
    end
  end
end
