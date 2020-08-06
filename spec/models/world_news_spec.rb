require 'rails_helper'

RSpec.describe WorldNews, type: :model do
  describe 'relationships' do
    it { should belong_to :campaign }
  end
end
