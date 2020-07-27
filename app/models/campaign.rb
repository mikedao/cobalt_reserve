class Campaign < ApplicationRecord
  has_many :characters

  def self.current
    find_by(status: "active")
  end
end
