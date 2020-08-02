class AdventureLog < ApplicationRecord
  belongs_to :character
  belongs_to :game_session
end
