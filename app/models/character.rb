class Character < ApplicationRecord
  belongs_to :campaign
  belongs_to :user
  has_many :game_session_characters
  has_many :game_sessions, through: :game_session_characters
  has_many :item_characters
  has_many :items, through: :item_characters
  has_many :adventure_logs

  belongs_to :ancestryone
  belongs_to :ancestrytwo, optional: true
  belongs_to :culture

  validates :level, presence: true, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 1,
                                                    less_than_or_equal_to: 20 }
  validates :name, uniqueness: true, presence: true, length: { minimum: 2 }
  validates :dndbeyond_url, uniqueness: true, presence: true
  validates :klass, presence: true

  scope :active, -> { where active: true }

  def build_ancestry
    ancestries = [ancestryone.name]
    ancestries << ancestrytwo.name unless ancestrytwo.nil?
    ancestries.join(' / ')
  end

  # https://www.dndbeyond.com/classes
  def self.classes
    ['Artificer', 'Barbarian', 'Bard', 'Blood Hunter', 'Cleric', 'Druid', 'Fighter', 'Monk', 'Paladin', 'Ranger',
     'Rogue', 'Sorcerer', 'Warlock', 'Wizard']
  end
end
