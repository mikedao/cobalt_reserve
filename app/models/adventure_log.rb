class AdventureLog < ApplicationRecord
  belongs_to :character
  belongs_to :game_session

  validates_length_of :content, minimum: 1
end
