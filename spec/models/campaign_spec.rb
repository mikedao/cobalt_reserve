require "rails_helper"

RSpec.describe Campaign, type: :model do
  describe "relationships" do
    it { should have_many :characters }
    it { should have_many :game_sessions }
  end

  describe "class methods" do
    it ".current" do
      campaign1 = Campaign.create(name: "First", status: "inactive")
      campaign2 = Campaign.create(name: "Second Campaign", status: "active")

      expect(Campaign.current).to eq(campaign2)

      campaign3 = Campaign.create(name: "Third", status: "active")

      expect(Campaign.current).to eq(campaign2)
    end
  end
end
