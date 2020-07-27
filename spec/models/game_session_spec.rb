require "rails_helper"

RSpec.describe GameSession, type: :model do
  describe "relationships" do
    it { should belong_to :campaign }
    it { should have_many :game_session_characters }
    it { should have_many(:characters).through(:game_session_characters) }
  end
end
