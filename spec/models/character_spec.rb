require 'rails_helper'

RSpec.describe Character, type: :model do
  describe 'relationships' do
    it { should belong_to :campaign }
    it { should belong_to :user }
    it { should have_many :game_session_characters }
    it { should have_many(:game_sessions).through(:game_session_characters) }
    it { should have_many :item_characters }
    it { should have_many(:items).through(:item_characters) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dndbeyond_url) }
    it { should validate_presence_of :species }
    it { should validate_presence_of :character_class }
    it { should validate_presence_of :level }
    it { should validate_numericality_of(:level).only_integer }

    describe 'doing things the hard way' do
      before :each do
        @user = create(:user)
        @campaign = create(:campaign)
        @c1 = create(
          :character,
          user: @user,
          campaign: @campaign,
          character_class: 'Bard',
          name: 'Taylor Swift',
          dndbeyond_url: 'http://dndbeyond.com/1234'
        )
        @c2 = nil
      end

      it 'should validate uniqueness of name the hard way because shoulda_matchers is being a jerk' do
        begin
          @c2 = create(
            :character,
            user: @user,
            campaign: @campaign,
            character_class: 'Bard',
            name: 'Taylor Swift',
            dndbeyond_url: 'http://dndbeyond.com/123456'
          )
        rescue ActiveRecord::RecordInvalid => e
          expect(e.message).to eq('Validation failed: Name has already been taken')
        end
        expect(@c2).to be_a(NilClass)
      end

      it 'should validate uniqueness of dndbeyond_url the hard way because shoulda_matchers is being a jerk' do
        begin
          @c3 = create(:character, user: @user, campaign: @campaign, dndbeyond_url: 'http://dndbeyond.com/1234')
        rescue ActiveRecord::RecordInvalid => e
          expect(e.message).to eq('Validation failed: Dndbeyond url has already been taken')
        end
        expect(@c3).to be_a(NilClass)
      end

      it 'validates that level is an integer between 1 and 20 because shoulda_matchers is being a jerk' do
        begin
          @c3 = create(:character, user: @user, campaign: @campaign, name: 'foo', character_class: 'yeah',
                       species: 'nope', dndbeyond_url: 'whatever', level: -1)
        rescue ActiveRecord::RecordInvalid => e
          expect(e.message).to eq('Validation failed: Level must be greater than 1')
        end
        expect(@c3).to be_a(NilClass)

        begin
          @c3 = create(:character, user: @user, campaign: @campaign, name: 'foo', character_class: 'yeah',
                       species: 'nope', dndbeyond_url: 'whatever', level: 21)
        rescue ActiveRecord::RecordInvalid => e
          expect(e.message).to eq('Validation failed: Level must be less than or equal to 20')
        end
        expect(@c3).to be_a(NilClass)
      end
    end
  end

  describe 'default properties' do
    it 'sets appropriate default values when creating a character' do
      user = User.new(username: 'Taylor Swift', email: 't@swift.com', password: 'cardigan', status: 'active')
      campaign = Campaign.new(name: 'Test Campaign', status: 'active')
      char = Character.new(name: 'Melodia', character_class: 'Bard', level: 5, user: user, campaign: campaign)

      expect(char.active).to eq(false)
    end
  end

  describe 'class methods' do
    it '.classes' do
      classes = Character.classes

      expect(classes).to be_a(Array)
      expect(classes).to include('Barbarian')
      expect(classes).to include('Bard')
      expect(classes).to include('Cleric')
      expect(classes).to include('Druid')
      expect(classes).to include('Fighter')
      expect(classes).to include('Monk')
      expect(classes).to include('Paladin')
      expect(classes).to include('Ranger')
      expect(classes).to include('Rogue')
      expect(classes).to include('Sorcerer')
      expect(classes).to include('Warlock')
      expect(classes).to include('Wizard')
      expect(classes).to include('Artificer')
      expect(classes).to include('Blood Hunter')
    end

    it '.species' do
      species = Character.species

      expect(species).to be_a(Array)
      expect(species).to include('Dragonborn')
      expect(species).to include('Dwarf')
      expect(species).to include('Elf')
      expect(species).to include('Gnome')
      expect(species).to include('Half-Elf')
      expect(species).to include('Halfling')
      expect(species).to include('Half-Orc')
      expect(species).to include('Human')
      expect(species).to include('Tiefling')
      expect(species).to include('Orc of Exandria')
      expect(species).to include('Leonin')
      expect(species).to include('Satyr')
      expect(species).to include('Aarakocra')
      expect(species).to include('Genasi')
      expect(species).to include('Goliath')
      expect(species).to include('Aasimar')
      expect(species).to include('Bugbear')
      expect(species).to include('Firbolg')
      expect(species).to include('Goblin')
      expect(species).to include('Hobgoblin')
      expect(species).to include('Kenku')
      expect(species).to include('Kobold')
      expect(species).to include('Lizardfolk')
      expect(species).to include('Orc')
      expect(species).to include('Tabaxi')
      expect(species).to include('Triton')
      expect(species).to include('Yuan-ti Pureblood')
      expect(species).to include('Feral Tiefling')
      expect(species).to include('Tortle')
      expect(species).to include('Changeling')
      expect(species).to include('Kalashatar')
      expect(species).to include('Orc of Eberron')
      expect(species).to include('Shifter')
      expect(species).to include('Warforged')
      expect(species).to include('Gith')
      expect(species).to include('Centaur')
      expect(species).to include('Loxodon')
      expect(species).to include('Minotaur')
      expect(species).to include('Simic Hybrid')
      expect(species).to include('Vedalken')
      expect(species).to include('Verdan')
      expect(species).to include('Locathah')
      expect(species).to include('Grung')
    end
  end

end
