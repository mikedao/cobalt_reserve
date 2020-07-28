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

  describe 'roles' do
    it 'can be created as an admin' do
      user = User.create(username: 'admin',
                         password: 'adminpass',
                         email:    'admin@example.com',
                         role:     1)

      expect(user.role).to eq('admin')
      expect(user.admin?).to be_truthy
    end

    it 'can be created as a default user' do
      user = User.create(username: 'admin',
                         password: 'adminpass',
                         email:    'admin@example.com',
                         role:     0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end
  end
end
