require 'faker'

FactoryBot.define do
  factory :campaign do
    name { Faker::Game.unique.title }
    status { 'active' }
  end
  factory :inactive_campaign, parent: :campaign do
    name { Faker::Game.unique.title }
    status { 'inactive' }
  end
end