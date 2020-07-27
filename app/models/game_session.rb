class GameSession < ApplicationRecord
  belongs_to :campaign
  has_many :game_session_characters
  has_many :characters, through: :game_session_characters
end
