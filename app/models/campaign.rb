class Campaign < ApplicationRecord
  has_many :characters
  has_many :game_sessions
  has_many :world_news

  def self.current
    find_by(status: 'active')
  end
end
