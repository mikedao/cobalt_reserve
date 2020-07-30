require 'faker'

FactoryBot.define do
  factory :game_session do
    name { Faker::Games::Zelda.location }
    date { Faker::Date.between(from: 1.month.ago, to: Date.today) }
    campaign
  end
end
