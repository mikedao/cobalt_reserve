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

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :species }
    it { should validate_presence_of :character_class }
    it { should validate_presence_of :level }
  end

  describe 'default properties' do
    it 'sets appropriate default values when creating a character' do
      user = User.new(username: 'Taylor Swift', email: 't@swift.com', password: 'cardigan', status: 'active')
      campaign = Campaign.new(name: 'Test Campaign', status: 'active')
      char = Character.new(name: 'Melodia', character_class: 'Bard', level: 5, user: user, campaign: campaign)

      expect(char.active).to eq(false)
    end
  end
end
