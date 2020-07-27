require "rails_helper"

RSpec.describe Character, type: :model do
  describe "relationships" do
    it { should belong_to :campaign }
    it { should belong_to :user }
    it { should have_many :item_characters }
    it { should have_many(:items).through(:item_characters) }
  end
end
