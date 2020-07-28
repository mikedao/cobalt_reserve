require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'relationships' do
    it { should belong_to :campaign }
    it { should belong_to :user }
    it { should have_many :game_session_characters }
    it { should have_many(:game_sessions).through(:game_session_characters) }
    it { should have_many :item_characters }
    it { should have_many(:items).through(:item_characters) }
  end

  describe 'default properties' do
    it 'sets appropriate default values when creating a character' do
      user = User.new(username: 'Taylor Swift', email: 't@swift.com', password: 'cardigan', status: 'active')
      campaign = Campaign.new(name: 'Test Campaign', status: 'active')
      char = Character.new(name: 'Melodia', character_class: 'Bard', user: user, campaign: campaign)

      expect(char.active).to eq(false)
    end
  end
end
