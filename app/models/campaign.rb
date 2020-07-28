class Campaign < ApplicationRecord
  has_many :characters
  has_many :game_sessions

  def self.current
    find_by(status: 'active')
  end
end
