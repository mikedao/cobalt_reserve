require 'rails_helper'

RSpec.describe ItemPlayer, type: :model do
  describe "relationships" do
    it { should belong_to :item }
    it { should belong_to :player }
  end
end