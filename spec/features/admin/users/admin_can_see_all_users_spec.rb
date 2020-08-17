require 'rails_helper'

RSpec.describe 'admin user index page' do
  context 'as an admin user' do
    it 'sees a list of all users in the system' do
      create(:campaign)
      admin = create(:admin_user)
      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      login_as_user(admin.username, admin.password)

      visit admin_users_path

      expect(page).to have_content(user_1.id)
      expect(page).to have_content(user_1.username)
      expect(page).to have_content(user_1.first_name)
      expect(page).to have_content(user_1.last_name)
      expect(page).to have_content(user_1.email)

      expect(page).to have_content(user_2.id)
      expect(page).to have_content(user_2.username)
      expect(page).to have_content(user_2.first_name)
      expect(page).to have_content(user_2.last_name)
      expect(page).to have_content(user_2.email)

      expect(page).to have_content(user_3.id)
      expect(page).to have_content(user_3.username)
      expect(page).to have_content(user_3.first_name)
      expect(page).to have_content(user_3.last_name)
      expect(page).to have_content(user_3.email)
    end
  end

  context 'as a user' do
    it 'does not let me access user management' do
      create(:campaign)
      user = create(:user)

      login_as_user(user.username, user.password)

      visit admin_users_path

      expect(current_path).to eq(root_path)
    end
  end

  context 'as a visitor' do
    it 'does not let me access user management' do
      create(:campaign)

      visit admin_users_path

      expect(current_path).to eq(root_path)
    end
  end
end
