require 'rails_helper'

RSpec.describe 'home page', type: :feature do
  context 'as a visitor' do
    it 'shows a welcome message on the home page if there are no active campaigns' do
      visit root_path
      expect(page).to have_content('Cobalt Reserve')
    end

    it 'can see an active campaign name on the home page if one exists' do
      campaign = Campaign.create(name: 'Turing West Marches', status: 'active')

      visit root_path
      expect(page).to have_content(campaign.name)
    end

    it 'can see a link which navigates to character index' do
      visit root_path
      click_link('Character Index')

      expect(current_path).to eq(characters_path)
    end
  end
end
