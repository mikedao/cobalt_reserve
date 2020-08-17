require 'rails_helper'

RSpec.describe 'admin user disable', type: :feature do
  context 'as an admin user' do
    it 'can make a user inactive' do
      create(:campaign)
      admin = create(:admin_user)
      user = create(:user)
      user_2 = create(:user)

      login_as_user(admin.username, admin.password)

      visit admin_users_path

      within("#user-#{user.id}") do
        click_on 'Details'
      end

      expect(page).to_not have_button('Enable User')
      click_on 'Disable User'

      expect(current_path).to eq(admin_users_path)

      within("#user-#{user.id}") do
        expect(page).to have_content('Inactive')
        expect(page).to_not have_content('Active')
      end

      within("#user-#{user_2.id}") do
        expect(page).to have_content('Active')
        expect(page).to_not have_content('Inactive')
      end
    end

    it 'can enable a disabled user' do
      create(:campaign)
      admin = create(:admin_user)
      user = create(:user, active: false)

      login_as_user(admin.username, admin.password)

      visit admin_users_path

      within("#user-#{user.id}") do
        expect(page).to have_content('Inactive')
        expect(page).to_not have_content('Active')
        click_on 'Details'
      end

      expect(page).to_not have_button('Disable User')
      click_on 'Enable User'

      expect(current_path).to eq(admin_users_path)

      within("#user-#{user.id}") do
        expect(page).to have_content('Active')
        expect(page).to_not have_content('Inactive')
        click_on 'Details'
      end
    end
  end
end
