require "rails_helper"

RSpec.describe GameSession, type: :model do
  describe "relationships" do
    it { should belong_to :campaign }
  end
end
