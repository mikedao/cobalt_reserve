require 'rails_helper'

RSpec.describe 'home page', type: :feature do
  context 'as a user' do
    it 'can see the campaign name on the home page' do
      campaign = Campaign.create(name: 'Turing West Marches', status: 'active')

      visit root_path
      expect(page).to have_content(campaign.name)
    end
  end
end
