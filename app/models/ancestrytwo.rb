class Ancestrytwo < ApplicationRecord
  # sync this EXACTLY with Ancestryone, Ancestrytwo, Culture

  self.table_name = 'species'

  validates :name, uniqueness: true, presence: true
  validates :active, presence: true

  has_many :characters
end
