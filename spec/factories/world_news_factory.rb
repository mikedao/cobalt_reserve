require 'faker'

FactoryBot.define do
  factory :world_news do
    date { Faker::Business.credit_card_expiry_date }
    title { Faker::Movies::HitchhikersGuideToTheGalaxy.unique.marvin_quote }
    body { Faker::Movies::HitchhikersGuideToTheGalaxy.unique.quote }
    campaign
  end
end
