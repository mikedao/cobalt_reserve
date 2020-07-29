require 'rails_helper'

RSpec.describe 'Logging In', type: :feature do
  it 'can log in with valid credentials' do
    Campaign.create(name: 'Turing West Marches', status: 'active')
    user = User.create(username: 'funbucket13',
                       password: 'test',
                       email: 'bucket@example.com')

    visit root_path
    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in :username, with: user.username
    fill_in :password, with: user.password
    click_button 'Log In'

    expect(current_path).to eq(profile_path)

    expect(page).to have_content("Welcome, #{user.username}")
    expect(page).to have_link('Log Out')
    expect(page).to_not have_link('Register')

    click_on 'Log Out'

    expect(current_path).to eq root_path
    expect(page).to have_content('You have successfully logged out.')
  end
end
