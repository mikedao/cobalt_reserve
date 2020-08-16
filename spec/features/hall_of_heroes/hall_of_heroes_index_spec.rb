require 'rails_helper'

RSpec.describe 'Hall of Heroes Index Page', type: :feature do
  context 'as a visitor' do
    it 'displays all deceased characters for the active campaign' do
      campaign = create(:campaign)
      user = create(:user)
      dead_1 = create(:dead_character, user: user, campaign: campaign)
      dead_2 = create(:dead_character, user: user, campaign: campaign)
      alive = create(:character, user: user, campaign: campaign)

      visit '/hall-of-heroes'

      expect(page).to have_content(dead_1.name)
      expect(page).to have_content(dead_2.name)
      expect(page).to_not have_content(alive.name)
    end
  end
end
