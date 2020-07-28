require 'rails_helper'

RSpec.describe 'Logging In', type: :feature do
  before :each do
    Campaign.create(name: 'Turing West Marches', status: 'active')

    @user = User.create(
      username: 'funbucket13',
      password: 'test',
      email: 'bucket@example.com',
      status: 'active'
    )
    @inactive_user = User.create(
      username: 'sadbucket42',
      password: 'test',
      email: 'sadbucket@example.com',
      status: 'inactive'
    )
  end

  it 'can log in with valid credentials' do
    visit '/'
    click_on 'Log In'

    expect(current_path).to eq('/login')

    fill_in :username, with: @user.username
    fill_in :password, with: @user.password

    click_button 'Log In'

    expect(current_path).to eq('/profile')

    expect(page).to have_content("Welcome, #{@user.username}")
    expect(page).to have_link('Log Out')
    expect(page).to_not have_link('Register')
    expect(page).to_not have_link('I already have an account')
  end

  it 'cannot log in with bad credentials' do
    visit '/'
    click_on 'Log In'

    expect(current_path).to eq('/login')

    fill_in :username, with: @user.username
    fill_in :password, with: 'Clearly incorrect'

    click_button 'Log In'

    expect(current_path).to eq('/login')

    expect(page).to have_content('Sorry, your credentials are bad.')
  end

  describe 'with passwordless authentication' do
    before :each do
      @fake_uuid = 'abc-123'
      allow(SecureRandom).to receive(:uuid) { @fake_uuid }
    end

    it 'follows the auth process successfully' do
      visit '/'

      click_on 'Passwordless Login'
      expect(current_path).to eq('/passwordless-login')

      within('#user-select') do
        expect(page).to_not have_content(@inactive_user.username)
      end

      select @user.username, from: 'user-select'
      click_button 'Auth by Email'

      expect(current_path).to eq('/passwordless-login')
      expect(page).to have_content('Thank you, you will receive an email with a link to return to the Cobalt Reserve.')
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

      select @user.username, from: 'user-select'
      click_button 'Auth by Email'

      @user.update!(login_timestamp: DateTime.now - 15.minutes)

      visit "/auth/#{@fake_uuid}"

      expect(page).to have_content('Sorry, that login link has expired. Please log in again.')
    end

    it 'fails if an invalid user is forced into the form' do
      page.driver.post('/passwordless-login', { params: { 'user-select': '-1' } })

      expect(page).to have_content('You are being redirected')
    end

    it 'fails if user is deactivated between trying to login and clicking the auth link' do
      @user.update!(status: 'inactive')

      visit "/auth/#{@fake_uuid}"

      expect(page).to have_content('Sorry, I have no idea who you are. Please log in again.')
    end

    it 'fails if uuid is invalid' do
      visit '/auth/ljadflkjoja09wjf3f'

      expect(page).to have_content('Sorry, I have no idea who you are. Please log in again.')
    end
  end
end
