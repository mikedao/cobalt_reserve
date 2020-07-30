require 'faker'

FactoryBot.define do
  factory :monster do
    name { Faker::Games::Pokemon.unique.name }
    size { %w[Tiny Small Medium Large Giant].sample }
    monster_type { Faker::Games::DnD.species }
    alignment { Faker::Games::DnD.alignment }
    ac { Faker::Number.within(range: 5..15) }
    hp { Faker::Number.within(range: 5..15) }
    speed { "#{Faker::Number.within(range: 10..50)}, #{Faker::Number.within(range: 20..100)} #{['Walk', 'Run', 'Fly'].sample}" }
    str { Faker::Number.within(range: 5..15) }
    dex { Faker::Number.within(range: 5..15) }
    con { Faker::Number.within(range: 5..15) }
    int { Faker::Number.within(range: 5..15) }
    wis { Faker::Number.within(range: 5..15) }
    cha { Faker::Number.within(range: 5..15) }
    languages { Faker::Nation.language }
    challenge_rating { Faker::Number.decimal(l_digits: 2, r_digits: 3) }
    additional_abilities { 3.times.map{Faker::Verb.ing_form}.join(', ') }
    source { Faker::Book.title }
    author { Faker::Book.author }
  end
end
