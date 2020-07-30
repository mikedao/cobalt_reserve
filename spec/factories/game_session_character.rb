require 'faker'

FactoryBot.define do
  factory :game_session_character do
    game_session
    character
  end
end
