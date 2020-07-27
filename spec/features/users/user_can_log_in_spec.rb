require "rails_helper"

RSpec.describe "Logging In", type: :feature do
  it "can log in with valid credentials" do
    Campaign.create(name: "Turing West Marches", status: "active")
    user = User.create(username: "funbucket13",
                       password: "test",
                       email: "bucket@example.com")

    visit "/"

    click_on "Log In"

    expect(current_path).to eq("/login")

    fill_in :username, with: user.username
    fill_in :password, with: user.password

    click_button "Log In"

    expect(current_path).to eq("/profile")

    expect(page).to have_content("Welcome, #{user.username}")
    expect(page).to have_link("Log Out")
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

    expect(current_path).to eq("/login")

    fill_in :username, with: user.username
    fill_in :password, with: "Clearly incorrect"

    click_button "Log In"

    expect(current_path).to eq("/login")

    expect(page).to have_content("Sorry, your credentials are bad.")
  end

  describe 'with passwordless authentication' do
    before :each do
      @fake_uuid = 'abc-123'
      allow(SecureRandom).to receive(:uuid) { @fake_uuid }
      campaign = Campaign.create!(name: 'Turing West Marches', status: 'active')
      @user = User.create!(username: 'funbucket13',
                          password: 'test',
                          email: 'bucket@example.com')
      @character = Character.create!(user: @user, campaign: campaign, name: 'Cormyn')
    end

    it 'follows the auth process successfully' do
      visit '/'

      click_on 'Passwordless Login'
      expect(current_path).to eq('/passwordless-login')

      select @character.name, from: 'character-select'
      click_button 'Auth by Email'

      expect(current_path).to eq('/passwordless-login')
      expect(page).to have_content('Thank you, your character will receive an email with a link to return to the Cobalt Reserve.')
      expect(page).to have_content('This link will expire in 10 minutes')

      visit "/auth/#{@fake_uuid}"

      expect(current_path).to eq('/profile')
      expect(page).to have_link('Log Out')
      expect(page).to have_content("Welcome, #{@user.username}")
    end

    it 'fails if uuid is too old' do
      visit '/'

      click_on 'Passwordless Login'
      expect(current_path).to eq('/passwordless-login')

      select @character.name, from: 'character-select'
      click_button 'Auth by Email'

      @user.update!(login_timestamp: DateTime.now - 15.minutes)

      visit "/auth/#{@fake_uuid}"

      expect(page).to have_content('Sorry, that login link has expired. Please try to log in again.')
    end

    it 'fails if an invalid character is forced into the form' do
      page.driver.post('/passwordless-login', { params: { 'character-select': '-1' } })

      expect(page).to have_content('You are being redirected')
    end

    it 'fails if uuid is invalid' do
      visit '/auth/ljadflkjoja09wjf3f'

      expect(page).to have_content('Sorry, I have no idea who you are. Please try to log in again.')
    end
  end
end
