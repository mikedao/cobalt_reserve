require 'rails_helper'

RSpec.describe 'admin user show page', type: :feature do
  context 'as an admin user' do
    it 'can get to show page from user management' do
      create(:campaign)
      admin = create(:admin_user)
      user_1 = create(:user)
      user_2 = create(:user)

      login_as_user(admin.username, admin.password)

      visit admin_users_path

      within "#user-#{user_1.id}" do
        click_on 'Details'
      end

      expect(current_path).to eq(admin_user_path(user_1))
      expect(page).to have_content(user_1.id)
      expect(page).to have_content(user_1.username)
      expect(page).to have_content(user_1.first_name)
      expect(page).to have_content(user_1.last_name)
      expect(page).to have_content(user_1.email)

      expect(page).to_not have_content(user_2.id)
      expect(page).to_not have_content(user_2.username)
      expect(page).to_not have_content(user_2.first_name)
      expect(page).to_not have_content(user_2.last_name)
      expect(page).to_not have_content(user_2.email)
    end
  end
end
