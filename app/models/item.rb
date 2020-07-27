class Item < ApplicationRecord
  validates_presence_of :name, :description
  has_many :item_players
  has_many :players, through: :item_players
end