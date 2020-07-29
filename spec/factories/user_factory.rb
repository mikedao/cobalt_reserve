require 'faker'

FactoryBot.define do
  sequence :email do |n|
    "adventurer#{n}@cobalt-reserve.com"
  end

  factory :user do
    username { Faker::Games::Witcher.unique.character.delete(' ') }
    email
    password { 'password' }
    role { 0 }
  end

  factory :admin_user, parent: :user do
    role { 1 }
  end
end