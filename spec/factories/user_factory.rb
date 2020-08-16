require 'faker'

FactoryBot.define do
  sequence :email do |n|
    "adventurer#{n}@cobalt-reserve.com"
  end

  factory :user do
    username { Faker::Games::Witcher.character.delete(' ') + Faker::Number.hexadecimal(digits: 4) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email
    password { 'password' }
    role { 0 }
  end

  factory :admin_user, parent: :user do
    role { 1 }
  end
end
