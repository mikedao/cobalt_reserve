require 'rails_helper'

RSpec.describe 'User registration form', type: :feature do
  context 'as a visitor' do
    it 'creates a new user' do
      Campaign.create(name: 'Turing West Marches', status: 'active')

      visit root_path

      click_on 'Register'

      expect(current_path).to eq '/users/new'

      username = 'BurtReynolds'
      password = 'hamburger1'
      first_name = 'Burt'
      last_name = 'Reynolds'
      email = 'burtreynolds@example.com'

      fill_in :username, with: username
      fill_in :password, with: password
      fill_in :password_confirmation, with: password
      fill_in :first_name, with: first_name
      fill_in :last_name, with: last_name
      fill_in :email, with: email

      click_on 'Create User'

      expect(page).to have_content "Welcome, #{username}!"
    end

    it "can't create a new user due to mismatch password and password confirmation" do
      Campaign.create(name: "Turing West Marches", status: "active")

      visit root_path

      click_on "Register"

      expect(current_path).to eq "/users/new"

      username = "BurtReynolds"
      password = "hamburger1"
      bad_password = "hotdog"
      first_name = "Burt"
      last_name = "Reynolds"
      email = "burtreynolds@example.com"

      fill_in :username, with: username
      fill_in :password, with: password
      fill_in :password_confirmation, with: bad_password
      fill_in :first_name, with: first_name
      fill_in :last_name, with: last_name
      fill_in :email, with: email

      click_on "Create User"

      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end
end
