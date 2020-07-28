require 'faker'

FactoryBot.define do
  factory :campaign do
    name { Faker::Game.unique.title }
    status { 'active' }
  end
end