require 'faker'

FactoryBot.define do
  factory :character do
    name { Faker::Games::WorldOfWarcraft.unique.hero }
    species { "Humanoid (#{Faker::Games::DnD.species}" }
    level { Faker::Number.within(range: 1..10) }
    character_class { "#{Faker::Games::DnD.klass} Class" }
    campaign
    user
    active { true }
  end
end