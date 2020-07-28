require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do
  it 'redirects to admin dashboard when admin logs in' do
    Campaign.create(name: 'test_campaign', status: 'active')
    user = User.create(username: 'admin',
                       password: 'test',
                       email: 'admin@example.com',
                       role: 1)

    visit '/'

    click_on 'Log In'

    expect(current_path).to eq ('/login')

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button 'Log In'

    expect(current_path).to eq('/admin/dashboard')
    expect(page).to have_content('Admin Dashboard')
  end

  it 'does not allow a default user to see the admin dashboard' do
    user = User.create(username: 'regular_user',
                       password: 'regular+pass',
                       email:    'reg@example.com',
                       role:     0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/admin/dashboard'

    expect(current_path).to eq(root_path)
  end
end

