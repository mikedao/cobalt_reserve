require 'rails_helper'

RSpec.describe 'Character Backstory', type: :feature do
  it 'can create a backstory for their character' do
    campaign = create(:campaign, status: 'active')
    user = create(:user)
    character = create(:character, user: user, campaign: campaign, active: true)

    login_as_user(user.username, user.password)
    visit character_path(character)
    click_on 'Edit Backstory'

    expect(current_path).to eq(backstory_edit_path(character))

    expect(page).to_not have_content('20 years')
    expect(page).to_not have_content('it sucked')
    expect(page).to_not have_content('Chaotic Salsa')
    expect(page).to_not have_content('meh')
    expect(page).to_not have_content('spiders')
    expect(page).to_not have_content('front')
    expect(page).to_not have_content('more')

    fill_in :character_age, with: '20 years'
    fill_in :character_early_life, with: 'it sucked'
    fill_in :character_moral_code, with: 'Chaotic Salsa'
    fill_in :character_personality, with: 'meh'
    fill_in :character_fears, with: 'spiders'
    fill_in :character_role, with: 'front'
    fill_in :character_additional_information, with: 'more'

    click_on 'Update Backstory'

    expect(current_path).to eq(character_path(character))

    expect(page).to have_content('20 years')
    expect(page).to have_content('it sucked')
    expect(page).to have_content('Chaotic Salsa')
    expect(page).to have_content('meh')
    expect(page).to have_content('spiders')
    expect(page).to have_content('front')
    expect(page).to have_content('more')
  end

  it 'cannot create a backstory for a character that it is not logged in as' do
    campaign = create(:campaign, status: 'active')
    user = create(:user)
    character = create(:character, user: user, campaign: campaign, active: true)
    user_2 = create(:user)
    character_2 = create(:character, user: user_2, campaign: campaign, active: true)

    login_as_user(user_2.username, user_2.password)

    expect(page).to_not have_selector(:link_or_button, 'Edit Backstory')

  end
end
