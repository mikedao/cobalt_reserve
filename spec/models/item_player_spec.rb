require 'rails_helper'

RSpec.describe ItemPlayer, type: :model do
  describe "relationships" do
    belongs_to :item
    belongs_to :player
  end
end