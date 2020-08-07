require 'faker'

FactoryBot.define do
  factory :world_news do
    date { Faker::Business.credit_card_expiry_date }
    title { Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote + Faker::Number.hexadecimal(digits: 4) }
    body { Faker::Movies::HitchhikersGuideToTheGalaxy.quote + Faker::Number.hexadecimal(digits: 4) }
    campaign
  end
end
