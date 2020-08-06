class WorldNews < ApplicationRecord
  belongs_to :campaign

  scope :most_recently_created, -> { order('created_at').last }
end
