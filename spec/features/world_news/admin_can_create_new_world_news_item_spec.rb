require 'rails_helper'

RSpec.describe 'admin creates world news item', type: :feature do
  context 'as an admin user' do
    it 'can create a world news item from the admin dashboard' do
      create(:campaign)
      admin = create(:admin_user)

      login_as_user(admin.username, admin.password)

      visit(admin_dashboard_path)

      click_on 'Create World News Item'

      expect(current_path).to eq(new_admin_world_news_path)

      fill_in :world_news_date, with: 'Some Date'
      fill_in :world_news_title, with: 'Title Goes Here'
      fill_in :world_news_body, with: 'Body'
      click_on 'Create World News'

      expect(current_path).to eq('/admin/world_news')
      expect(page).to have_content('Some Date')
      expect(page).to have_content('Title Goes Here')
    end
  end
end
