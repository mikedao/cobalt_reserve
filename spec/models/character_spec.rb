require "rails_helper"

RSpec.describe Character, type: :model do
  describe "relationships" do
    it { should belong_to :campaign }
    it { should belong_to :user }
  end
end

