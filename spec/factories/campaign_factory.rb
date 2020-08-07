require 'faker'

FactoryBot.define do
  factory :campaign do
    name { Faker::Game.title + Faker::Number.hexadecimal(digits: 4) }
    status { 'active' }
  end
  factory :inactive_campaign, parent: :campaign do
    name { Faker::Game.title + Faker::Number.hexadecimal(digits: 4) }
    status { 'inactive' }
  end
end
