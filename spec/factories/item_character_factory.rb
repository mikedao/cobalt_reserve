require 'faker'

FactoryBot.define do
  factory :item_character do
    item
    character
  end
end