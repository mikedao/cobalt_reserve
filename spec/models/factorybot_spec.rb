require 'rails_helper'

RSpec.describe 'FactoryBot Factories' do
  it 'ensures all factories can be instantiated' do
    create(:adventure_log)
    create(:campaign)
    create(:inactive_campaign)
    create(:ancestryone)
    create(:ancestrytwo)
    create(:culture)
    create(:character)
    create(:inactive_character)
    create(:game_session_character)
    create(:game_session)
    create(:item_character)
    create(:item)
    create(:user)
  end
end