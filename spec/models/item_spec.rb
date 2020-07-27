require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should have_many :item_players }
    it { should have_many(:players).through(:item_players) }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
  end
end