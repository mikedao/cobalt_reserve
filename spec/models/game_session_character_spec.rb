require 'rails_helper'

RSpec.describe GameSessionCharacter, type: :model do
  describe 'relationships' do
    it { should belong_to :game_session }
    it { should belong_to :character }
  end
end
