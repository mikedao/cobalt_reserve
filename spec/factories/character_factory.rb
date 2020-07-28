require 'faker'

FactoryBot.define do
  factory :character do
    name { Faker::Games::WorldOfWarcraft.unique.hero }
    species { Faker::Games::DnD.species }
    level { Faker::Number.within(range: 1..10) }
    character_class { Faker::Games::DnD.klass }
    campaign
    user
    active { true }
  end
end