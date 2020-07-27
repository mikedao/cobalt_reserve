class GameSessionCharacter < ApplicationRecord
  belongs_to :game_session
  belongs_to :character
end
