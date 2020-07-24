require "rails_helper"

RSpec.describe "Logging In", type: :feature do
  it "can log in with valid credentials" do
    Campaign.create(name: "Turing West Marches", status: "active")
    user = User.create(username: "funbucket13",
                       password: "test",
                       email: "bucket@example.com")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq('/login')

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_on "Log In"

    expect(current_path).to eq('/')

    expect(page).to have_content("Welcome, #{user.username}")
    expect(page).to have_link("Log out")
    expect(page).to_not have_link("Register")
    expect(page).to_not have_link("I already have an account")
  end

  it "cannot log in with bad credentials" do
    Campaign.create(name: "Turing West Marches", status: "active")

    user = User.create(username: "funbucket13",
                       password: "test",
                       email: "bucket@example.com")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq('/login')

    fill_in :username, with: user.username
    fill_in :password, with: "Clearly incorrect"

    click_on "Log In"

    expect(current_path).to eq('/login')

    expect(page).to have_content("Sorry, your credentials are bad.")
  end
end

