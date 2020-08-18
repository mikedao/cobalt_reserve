require 'rails_helper'

RSpec.describe 'Logging In', type: :feature do
  before :each do
    Campaign.create(name: 'Turing West Marches', status: 'active')

    @user = User.create(
      username: 'funbucket13',
      password: 'test',
      email: 'bucket@example.com',
    )
    @inactive_user = User.create(
      username: 'sadbucket42',
      password: 'test',
      email: 'sadbucket@example.com',
      active: false
    )
  end

  describe 'traditional username/password login' do
    describe 'happy path' do
      it 'allows user log in with valid credentials' do
        visit root_path
        click_on 'Log In'

        expect(current_path).to eq(login_path)

        fill_in :username, with: @user.username
        fill_in :password, with: @user.password
        click_button 'Log In'

        expect(current_path).to eq(profile_path)

        expect(page).to have_content("Welcome, #{@user.username}")
        expect(page).to have_link('Log Out')
        expect(page).to_not have_link('Register')
      end
    end

    describe 'sad path' do
      it 'cannot log in with bad credentials' do
        visit root_path
        click_on 'Log In'

        expect(current_path).to eq(login_path)

        fill_in :username, with: @user.username
        fill_in :password, with: 'Clearly incorrect'
        click_button 'Log In'

        expect(current_path).to eq(login_path)
        expect(page).to have_content('Unable to log in.')
      end
      it 'cannot log in with blank credentials' do
        visit root_path
        click_on 'Log In'

        expect(current_path).to eq(login_path)
        click_button 'Log In'

        expect(current_path).to eq(login_path)
        expect(page).to have_content('Unable to log in.')
      end

      describe 'with no users in the system' do
        before :each do
          @user.delete
          @inactive_user.delete
        end

        it 'shows a friendly error message instead of a crash error' do
          visit root_path
          click_on 'Log In'

          expect(current_path).to eq(login_path)

          fill_in :username, with: @user.username
          fill_in :password, with: 'Clearly incorrect'

          click_button 'Log In'

          expect(current_path).to eq(login_path)

          expect(page).to have_content('Unable to log in.')
        end
      end
    end
  end

  describe 'with passwordless authentication' do
    describe 'with users in the system' do
      before :each do
        @fake_uuid = 'abc-123'
        allow(SecureRandom).to receive(:uuid) { @fake_uuid }
      end

      it 'follows the auth process successfully' do
        visit root_path

        click_on 'Passwordless Log In'
        expect(current_path).to eq(passwordless_login_path)

        within('#user-select') do
          expect(page).to_not have_content(@inactive_user.username)
        end

        select @user.username, from: 'user-select'
        click_button 'Auth by Email'

        expect(current_path).to eq(passwordless_login_path)
        expect(page).to have_content('Thank you, you will receive an email with a link to return to the Cobalt Reserve.')
        expect(page).to have_content('This link will expire in 10 minutes')

        visit "/auth/#{@fake_uuid}"

        expect(current_path).to eq(profile_path)
        expect(page).to have_link('Log Out')
        expect(page).to have_content("Welcome, #{@user.username}")
      end

      it 'fails if uuid is too old' do
        visit root_path

        click_on 'Passwordless Log In'
        expect(current_path).to eq(passwordless_login_path)

        select @user.username, from: 'user-select'
        click_button 'Auth by Email'

        @user.update!(login_timestamp: DateTime.now - 15.minutes)

        visit "/auth/#{@fake_uuid}"

        expect(page).to have_content('Sorry, that login link has expired. Please log in again.')
      end

      it 'fails if an invalid user is forced into the form' do
        page.driver.post(passwordless_login_path, { params: { 'user-select': '-1' } })

        expect(page).to have_content('You are being redirected')
      end

      it 'fails if user is deactivated between trying to login and clicking the auth link' do
        @user.update!(active: false)

        visit passwordless_return_path(@fake_uuid)

        expect(page).to have_content('Sorry, I have no idea who you are. Please log in again.')
      end

      it 'fails if uuid is invalid' do
        visit passwordless_return_path('ljadflkjoja09wjf3f')

        expect(page).to have_content('Sorry, I have no idea who you are. Please log in again.')
      end
    end

    describe 'with no users in the system' do
      before :each do
        @user.delete
        @inactive_user.delete
      end

      it 'should show that passwordless auth is not available' do
        visit root_path

        click_on 'Passwordless Log In'
        expect(current_path).to eq(passwordless_login_path)

        expect(page).to have_content('There are no users; passwordless authentication will not work')
        expect(page).to_not have_css('#user-select')
      end
    end
  end
end
