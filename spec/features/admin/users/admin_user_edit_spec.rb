require 'rails_helper'

RSpec.describe 'admin user edit' do
  context 'as an admin user' do
    it 'can edit a users information' do
      create(:campaign)
      admin = create(:admin_user)
      user = User.create(username: 'raven',
                         first_name: 'mike',
                         last_name: 'dao',
                         email: 'taylor@example.com',
                         password: 'supersecure')

      login_as_user(admin.username, admin.password)

      visit admin_users_path

      within("#user-#{user.id}") do
        click_on 'Edit'
      end

      expect(current_path).to eq(edit_admin_user_path(user))

      fill_in :user_first_name, with: 'becky'
      fill_in :user_email, with: 'this_is_becky@example.com'
      click_on 'Update User'

      expect(current_path).to eq(admin_users_path)
      expect(page).to have_content('becky')
      expect(page).to have_content('this_is_becky@example.com')
      expect(page).to_not have_content('mike')
      expect(page).to_not have_content('taylor@example.com')
    end
  end
end
