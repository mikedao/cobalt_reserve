require 'rails_helper'

RSpec.describe 'character index', type: :feature do
  describe 'happy path (when there are characters in the db)' do
    before(:each) do
      @active_campaign = create(:campaign)
      @old_campaign = create(:campaign, status: 'inactive')
      @newer_campaign = create(:campaign)

      @character_1 = create(:character, campaign: @active_campaign) # expected
      @character_2 = create(:character, campaign: @active_campaign) # expected
      @character_3 = create(:character, campaign: @old_campaign)    # not expected
      @character_4 = create(:character, campaign: @newer_campaign)  # not expected
      @character_5 = create(:character, campaign: @active_campaign, active: false) # not expected
    end

    context 'as a visitor' do
      context 'when I visit /characters' do
        it 'I see a list of all the characters for the active campaign' do
          visit characters_path

          within "#char-#{@character_1.id}" do
            within '.card-header' do
              expect(page).to have_link(@character_1.name)
              expect(page).to have_content("Level #{@character_1.level} #{@character_1.klass}")
              expect(page).to have_content("Active Campaign Character")
            end
            within '.ancestry' do
              expect(page).to have_content(@character_1.build_ancestry)
            end
          end

          within "#char-#{@character_2.id}" do
            within '.card-header' do
              expect(page).to have_link(@character_2.name)
              expect(page).to have_content("Level #{@character_2.level} #{@character_2.klass}")
              expect(page).to have_content("Active Campaign Character")
            end
            within '.ancestry' do
              expect(page).to have_content(@character_2.build_ancestry)
            end
          end

          expect(page).not_to have_content(@character_3.name)
          expect(page).not_to have_content(@character_4.name)
          expect(page).not_to have_content(@character_5.name)

          expect(page).to have_css('.card-body', count: 2)
        end

        it "I click on a name and I am redirected to the character's show page" do
          visit characters_path
          click_on @character_1.name

          expect(current_path).to eq(character_path(@character_1))
        end
      end
    end
  end

  describe 'sad path (no characters in the db)' do
    context 'as a visitor' do
      context 'when I visit /characters' do
        before(:each) do
          visit characters_path
        end

        it 'I see a message that there are no characters yet' do
          expect(page).to have_content("There aren't any ... yet")
        end
      end
    end
  end
end
