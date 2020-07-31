require 'faker'

FactoryBot.define do
  factory :character do
    name { "#{Faker::Games::WorldOfWarcraft.hero} #{Faker::Number.number(digits: 3)}" }
    species { Character.species.drop(1).sample }
    level { Faker::Number.between(from: 1, to: 19).to_i+1 }
    character_class { Character.classes.drop(1).sample }
    campaign
    user
    dndbeyond_url { "http://dndbeyond/#{Faker::Number.within(range: 100000..999999)}"}
    active { true }
  end
end