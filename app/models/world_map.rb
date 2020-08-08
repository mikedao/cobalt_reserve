class WorldMap < ApplicationRecord
  belongs_to :campaign

  scope :ordered, -> { order("created_at").reverse }
  scope :latest_map, -> { order("created_at").last }
end
