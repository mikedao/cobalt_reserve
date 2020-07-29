class Character < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  has_many :game_session_characters
  has_many :game_sessions, through: :game_session_characters
  has_many :item_characters
  has_many :items, through: :item_characters

  validates_presence_of :name, :level
  validates :character_class, presence: true, length: { minimum: 4 }
  validates :species, presence: true, length: { minimum: 4 }

  # https://www.dndbeyond.com/classes
  def self.classes
    ['', 'Artificer', 'Barbarian', 'Bard', 'Blood Hunter', 'Cleric', 'Druid', 'Fighter', 'Monk', 'Paladin', 'Ranger',
     'Rogue', 'Sorcerer', 'Warlock', 'Wizard']
  end

  # https://www.dndbeyond.com/races
  def self.species
    ['', 'Aarakocra', 'Aasimar', 'Bugbear', 'Centaur', 'Changeling', 'Dragonborn', 'Dwarf', 'Elf', 'Feral Tiefling',
     'Firbolg', 'Genasi', 'Gith', 'Gnome', 'Goblin', 'Goliath', 'Grung', 'Half-Elf', 'Half-Orc', 'Halfling',
     'Hobgoblin', 'Human', 'Kalashatar', 'Kenku', 'Kobold', 'Leonin', 'Lizardfolk', 'Locathah', 'Loxodon',
     'Minotaur', 'Orc', 'Orc of Eberron', 'Orc of Exandria', 'Satyr', 'Shifter', 'Simic Hybrid', 'Tabaxi',
     'Tiefling', 'Tortle', 'Triton', 'Vedalken', 'Verdan', 'Warforged', 'Yuan-ti Pureblood']
  end
end
