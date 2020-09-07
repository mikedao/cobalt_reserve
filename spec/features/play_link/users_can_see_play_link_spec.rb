require 'rails_helper'

RSpec.describe 'play link', type: :feature do
  context 'as a user' do
    it 'shows me a play link in the nav bar' do
      create(:campaign)
      user = create(:user)

      login_as_user(user.username, user.password)

      visit root_path

      within('.navbar') do
        expect(page).to have_link('Play')
      end
    end
  end

  context 'as a visitor' do
    it 'does not have a play link in the nav bar' do
      create(:campaign)
      user = create(:user)

      login_as_user(user.username, user.password)

      visit root_path

      within('.navbar') do
        expect(page).to_not have_link('Play')
      end
    end
  end
end
