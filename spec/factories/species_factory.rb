require 'faker'

FactoryBot.define do
  factory :ancestryone, class: :Ancestryone do
    name { "#{Faker::Games::Pokemon.name} #{Faker::Number.number(digits: 3)}" }
    active { true }
  end

  factory :ancestrytwo, class: :Ancestrytwo do
    name { "#{Faker::Games::Pokemon.name} #{Faker::Number.number(digits: 3)}" }
    active { true }
  end

  factory :culture, class: :Culture do
    name { "#{Faker::Games::Pokemon.name} #{Faker::Number.number(digits: 3)}" }
    active { true }
  end
end
