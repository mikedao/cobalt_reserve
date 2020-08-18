require 'rails_helper'

RSpec.describe 'User Can Disable Self', type: :feature do
  context 'as a user' do
    it 'can disable itself from the profile page' do
      create(:campaign)
      user = create(:user)

      login_as_user(user.username, user.password)

      visit profile_path

      click_on 'Disable Account'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You have successfully disabled your account and logged out.')

      user.reload

      expect(user.active).to be false
    end
  end
end
