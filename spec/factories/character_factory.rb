require 'faker'

FactoryBot.define do
  factory :character do
    name { Faker::Games::WorldOfWarcraft.hero + Faker::Number.hexadecimal(digits: 4) }
    klass { Character.classes.drop(1).sample }
    level { Faker::Number.between(from: 1, to: 20).to_i }
    dndbeyond_url { "https://dndbeyond/#{Faker::Number.within(range: 100000..999999)}"}
    active { true }
    foundry_key { Faker::JapaneseMedia::SwordArtOnline.game_name }

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
