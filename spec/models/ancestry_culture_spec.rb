require 'rails_helper'

RSpec.describe Ancestryone, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:active) }
  end
  describe 'relationships' do
    it { should have_many :characters }
  end
end

RSpec.describe Ancestrytwo, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:active) }
  end
  describe 'relationships' do
    it { should have_many :characters }
  end
end

RSpec.describe Culture, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:active) }
  end
  describe 'relationships' do
    it { should have_many :characters }
  end
end
