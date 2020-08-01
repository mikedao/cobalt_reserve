require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many :characters }
    it { should have_many :adventure_logs }
  end

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password) }

    describe 'password confirmation' do
      it 'validates that password and password confirmation are the same' do
        password = 'sword'
        user = build(:user, password: password, password_confirmation: password)

        expect(user).to be_valid
      end

      it 'invalidates that password and password confirmation are different' do
        password = 'sword'
        password_confirmation = 'shield'
        user = build(:user, password: password, password_confirmation: password_confirmation)

        expect(user).not_to be_valid
      end
    end
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

  describe 'methods' do
    describe '.active_campaign_character' do
      before :each do
        @campaign = create(:campaign)
        @user = create(:user)
        @inactive_character = create(:inactive_character, user: @user, campaign: @campaign)
        @active_character = create(:character, user: @user, campaign: @campaign)
      end

      it 'succeeds for happy path conditions' do
        expect(@user.active_campaign_character).to eq(@active_character)
        expect(@user.active_campaign_character).to_not eq(@inactive_character)
      end

      it 'returns nil if user has no active character for current campaign' do
        @active_character.delete

        expect(@user.active_campaign_character).to eq(nil)
      end

      it 'returns nil if there is no current campaign' do
        @campaign.update(status: 'inactive')

        expect(@user.active_campaign_character).to eq(nil)
      end
    end
  end
end
