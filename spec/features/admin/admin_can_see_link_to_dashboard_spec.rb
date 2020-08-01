require 'rails_helper'

RSpec.describe 'admin dashboard link', type: :feature do
  context 'As a logged-in admin' do
    before do
      admin = create(:admin_user)
      login_as_user(admin.username, admin.password)
    end

    context 'when I am on any page' do
      it 'I can see a link on the navbar which links to the admin dashboard' do
        # representative sampling; link is on site-wide view
        paths = %w{/ /profile /monsters /characters}

        paths.each do |path|
          visit path
          within '.navbar-nav' do
            expect(page).to have_link('Admin Dashboard', href: '/admin/dashboard')
          end
        end
      end

      it 'I can click the admin dashboard link and be taken to it' do
        visit '/'
        click_on 'Admin Dashboard'
        expect(current_path).to eq '/admin/dashboard'
      end
    end
  end

  context 'As a normal user' do
    before do
      user = create(:user)
      login_as_user(user.username, user.password)
    end

    context 'when I am on any page' do
      it 'I do not see navbar link to admin dashboard' do
        visit '/'
        refute_admin_link_presence
      end
    end
  end

  context 'As a visitor' do
    context 'when I am on any page' do
      it 'I do not see navbar link to admin dashboard' do
        visit '/'
        refute_admin_link_presence
      end
    end
  end
end

def refute_admin_link_presence
  within '.navbar-nav' do
    expect(page).not_to have_link('Admin Dashboard')
  end
end