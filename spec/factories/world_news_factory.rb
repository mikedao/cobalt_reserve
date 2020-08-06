require 'faker'

FactoryBot.define do
  factory :world_news do
    date { Faker::Business.credit_card_expiry_date }
    title { Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote + Faker::Number.number(digits: 10).to_s }
    body { Faker::Movies::HitchhikersGuideToTheGalaxy.quote + Faker::Number.number(digits: 10).to_s }
    campaign
  end
end
