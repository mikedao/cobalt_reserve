FactoryBot.define do
  factory :world_map do
    low_res { "https://i.imgur.com/rBxkv0D.jpg" }
    high_res { "https://i.imgur.com/zPIS6Ig.jpg" }
    campaign
  end
end
