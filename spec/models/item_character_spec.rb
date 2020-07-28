require 'rails_helper'

RSpec.describe ItemCharacter, type: :model do
  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :character }
  end
end
