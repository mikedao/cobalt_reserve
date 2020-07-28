FactoryBot.define do
  factory :character do
    name { Faker::Games::WorldOfWarcraft.hero }
    race { Faker::Games::DnD.race } 
    level { Faker::Number.within(range: 1..10) }
    character_cless { Faker::Games::Dnd.klass }
    campaign
    user
  end
end