require 'faker'

FactoryBot.define do
  factory :item do
    name { Faker::Games::Zelda.item }
    description { Faker::Food.description }
  end
end