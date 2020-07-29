require 'faker'

FactoryBot.define do
  factory :character do
    name { Faker::Games::WorldOfWarcraft.unique.hero }
    species { "Humanoid (#{Faker::Games::DnD.species})" }
    level { (1..20).to_a.sample }
    character_class { "#{Faker::Games::DnD.klass} Class" }
    campaign
    user
    dndbeyond_url { "http://dndbeyond/#{Faker::Number.within(range: 100000..999999)}"}
    active { true }
  end
end