require 'rails_helper'

RSpec.describe GameSession, type: :model do
  describe 'relationships' do
    it { should belong_to :campaign }
    it { should have_many :game_session_characters }
    it { should have_many :adventure_logs }
    it { should have_many(:characters).through(:game_session_characters) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end

  describe 'methods' do
    describe 'instance methods' do
      describe 'best_adventure_log' do
        it 'returns adventure log marked best or nil if none present' do
          game_session_1 = create(:game_session)
          game_session_2 = create(:game_session)
          adventure_log_1 = create(:adventure_log)
          adventure_log_2 = create(:adventure_log, best: true)
          game_session_1.adventure_logs << [adventure_log_1, adventure_log_2]
          adventure_log_3 = create(:adventure_log)
          adventure_log_4 = create(:adventure_log)
          game_session_2.adventure_logs << [adventure_log_3, adventure_log_4]

          expect(game_session_1.best_adventure_log).to eq adventure_log_2
          expect(game_session_2.best_adventure_log).to be nil
        end
      end
    end
  end
end
