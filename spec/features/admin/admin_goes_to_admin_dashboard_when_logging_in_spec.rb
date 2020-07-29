require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  it 'redirects to admin dashboard when admin logs in' do
    Campaign.create(name: 'test_campaign', status: 'active')
    user = create(:admin_user)

    visit root_path
    click_on 'Log In'

    expect(current_path).to eq ('/login')

    fill_in :username, with: user.username
    fill_in :password, with: user.password
    click_button 'Log In'

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content('Admin Dashboard')
  end

  it 'does not allow a default user to see the admin dashboard' do
    user = create(:user)

    login_as_user(user.username, user.password)
    visit admin_dashboard_path

    expect(current_path).to eq(root_path)
  end
end

