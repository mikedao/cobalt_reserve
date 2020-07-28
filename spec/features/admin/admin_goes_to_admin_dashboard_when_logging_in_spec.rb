require "rails_helper"

RSpec.describe "Admin Dashboard", type: :feature do
  it "redirects to admin dashboard when admin logs in" do
    Campaign.create(name: "test_campaign", status: "active")
    user = User.create(username: "admin",
                        password: "test",
                        email: "admin@example.com",
                        status: "admin")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq ("/login")

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button "Log In"

    expect(current_path).to eq("/admin")
    expect(page).to have_content("Admin Dashboard")
  end
end

