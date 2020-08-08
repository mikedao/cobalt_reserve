class WorldMap < ApplicationRecord
  belongs_to :campaign

  scope :latest_map, -> { order("created_at").last }
end
