require 'rails_helper'

RSpec.describe AdventureLog, type: :model do
  describe 'relationships' do
    it { should belong_to :game_session }
    it { should belong_to :character }
  end

  describe 'validations' do
    it { should validate_length_of(:content).is_at_least(1) }
  end
end
