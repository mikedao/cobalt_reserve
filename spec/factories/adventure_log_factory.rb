require 'faker'

FactoryBot.define do
  factory :adventure_log do
    content { 3.times.map{Faker::Movie.quote}.join(' ') }
    character
    game_session
  end
end
