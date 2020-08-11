class GameSession < ApplicationRecord
  belongs_to :campaign
  has_many :game_session_characters
  has_many :adventure_logs
  has_many :characters, through: :game_session_characters

  validates_presence_of :name

  def best_adventure_log
    adventure_logs.find_by(best: true)
  end
end
