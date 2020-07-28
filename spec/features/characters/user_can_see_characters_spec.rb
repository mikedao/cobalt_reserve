require "rails_helper"

RSpec.describe "character index", type: :feature do
  before(:each) do
    @active_campaign = create(:campaign)
    @old_campaign = create(:campaign, status: 'inactive')
    @newer_campaign = create(:campaign)

    @character_1 = create(:character, campaign: @active_campaign) # expected
    @character_2 = create(:character, campaign: @active_campaign) # expected
    @character_3 = create(:character, campaign: @old_campaign)    # not expected
    @character_4 = create(:character, campaign: @newer_campaign)  # not expected
  end

  context "as a visitor" do
    context "when I visit /characters" do
      before(:each) do
        visit "/characters"
      end

      it "I see a list of all the characters for the active campaign" do
        expect(page).to have_content(@character_1.name)
        expect(page).to have_content(@character_2.name)
        expect(page).not_to have_content(@character_3.name)
        expect(page).not_to have_content(@character_4.name)
      end
    end
  end
end