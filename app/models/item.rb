class Item < ApplicationRecord
  validates_presence_of :name, :description
  has_many :item_characters
  has_many :character, through: :item_characters
end