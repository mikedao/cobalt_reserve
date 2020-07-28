require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :characters }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }
  end

  describe 'instance methods' do
    it '#admin?' do
      user1 = User.create(username: 'admin',
                          password: 'test',
                          email: 'admin@example.com',
                          status: 'admin')
      user2 = User.create(username: 'notadmin',
                          password: 'password',
                          email: 'not_admin@example.com')

      expect(user1.admin?).to be true
      expect(user2.admin?).to be false
    end
  end
end
