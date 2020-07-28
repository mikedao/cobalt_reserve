require "faker"

FactoryBot.define do
  factory :character do
    name { Faker::Games::WorldOfWarcraft.hero }
    race { Faker::Games::DnD.species } 
    level { Faker::Number.within(range: 1..10) }
    character_class { Faker::Games::DnD.klass }
    campaign
    user
  end
end