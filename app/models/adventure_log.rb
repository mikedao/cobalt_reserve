class AdventureLog < ApplicationRecord
  belongs_to :character
  belongs_to :game_session

  validates_length_of :content, minimum: 1

  default_scope { order :created_at }
  scope :not_best, -> { where best: false }
end
