class Campaign < ApplicationRecord
  has_many :characters
  has_many :game_sessions
  has_many :world_news
  has_many :world_maps, :dependent => :delete_all

  def self.current
    find_by(status: 'active')
  end

  def latest_low_res
    world_maps.latest_map.low_res
  end

  def latest_high_res
    world_maps.latest_map.high_res
  end

  def heroes
    characters.dead
  end
end
