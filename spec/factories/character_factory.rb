require 'faker'

FactoryBot.define do
  factory :character do
    name { "#{Faker::Games::WorldOfWarcraft.hero} #{Faker::Number.number(digits: 3)}" }
    klass { Character.classes.drop(1).sample }
    level { Faker::Number.between(from: 1, to: 19).to_i+1 }
    dndbeyond_url { "https://dndbeyond/#{Faker::Number.within(range: 100000..999999)}"}
    active { true }

    ancestryone
    ancestrytwo
    culture
    campaign
    user
  end

  factory :inactive_character, parent: :character do
    active { false }
  end
end