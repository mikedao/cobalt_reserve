require 'faker'

FactoryBot.define do
  factory :world_news do
    date { Faker::Business.credit_card_expiry_date }
    title { Faker::Movies::HitchhikersGuideToTheGalaxy.marvin_quote }
    body { Faker::Movies::HitchhikersGuideToTheGalaxy.quote }
    campaign
  end
end
