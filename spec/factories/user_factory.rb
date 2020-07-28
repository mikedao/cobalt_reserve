require "faker"

FactoryBot.define do
  sequence :email do |n|
    "adventurer#{n}@cobalt-reserve.com"
  end

  factory :user do
    username { Faker::Games::Witcher.unique.character.gsub(' ','') } 
    email
    password { 'password' }
  end
end